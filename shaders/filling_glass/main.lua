--- Shader-based example for filling a glass X percent.

--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- [ MIT license: http://www.opensource.org/licenses/mit-license.php ]
--

-- Color for liquid objects --
local LowerColor = { 1, 0xB3 / 255, 0x45 / 255 }
local UpperColor = { 1, 0x97 / 255, 0x01 / 255 }
local InOpenColor = { 1, 0x33 / 255, 0 }

-- Finds an ellipse constant, where the input is one of the four coordinates: (+-x, 0) or (0, +-y)
local function FindConstant (x)
	return 1 / x^2
end

-- Pixel-based center y-values of the lower and upper ellipses --
local LowerRawY, UpperRawY = 273, 26

-- Pixel-based bottom y-values of the lower and upper ellipses --
local LowerBottom, UpperBottom = 295, 53

-- Image dimensions --
local W, H = 204, 296

-- Normalized offsets, i.e. in the range (-1, +1), of the lower and upper edges of the glass --
local LowerX = 178 / W - .5
local UpperX = 202 / W - .5

-- "A" constants, from the ellipse equation A * x^2 + B * y^2 = 1, for the lower and upper ellipses... --
local LowerA = FindConstant(LowerX)
local UpperA = FindConstant(UpperX)

-- ...and the "B" constants --
local LowerB = FindConstant((LowerBottom - LowerRawY) / H)
local UpperB = FindConstant((UpperBottom - UpperRawY) / H)

-- Eccentrities (non-circularness) of the lower and upper ellipses --
local LowerE = LowerB / LowerA
local UpperE = UpperB / UpperA

-- Normalized (in the range [0, 1]) y-values of the centers of the lower and upper ellipses --
local LowerCenterY = LowerRawY / H
local UpperCenterY = UpperRawY / H

-- Wrapper for common kernel define logic
local function DefineKernel (name, code)
	local kernel = { category = "filter", name = name }

	kernel.vertexData = {
		{
			name = "y", -- center of the ellipse, in normalized coordinates, i.e. in [0, 1]
			default = 0, min = 0, max = 1,
			index = 0
		},
		{
			name = "a", -- ellipse constant for x...
			default = 10, min = 0, max = 100,
			index = 1
		},
		{
			name = "b", -- ...and for y
			default = 10, min = 0, max = 100,
			index = 2
		}
		-- still another slot left for whatever
	}

	kernel.fragment = code

	graphics.defineEffect(kernel)
end

-- Shader that renders the surface of the liquid when it's not straddling the lip of the glass --
DefineKernel("inside_ellipse", [[
	P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
	{
		P_POSITION vec2 pos = uv - vec2(.5, CoronaVertexUserData.x);
		P_POSITION vec2 square = pos * pos; // This is (x^2, y^2)

		// The two lines with "scale" may be used instead, as a "branch-free" computation.
		// Similar approaches could be followed in the other shaders, too.

		if (dot(square, CoronaVertexUserData.yz) > 1.) return vec4(0.); // The dot product is A * x^2 + B * y^2
//		P_COLOR float scale = step(dot(square, CoronaVertexUserData.yz), 1.);

		return CoronaColorScale(texture2D(CoronaSampler0, uv));
//		return CoronaColorScale(texture2D(CoronaSampler0, uv)) * scale;
	}
]])

-- Shader that renders the "below the surface" part of the liquid --
DefineKernel("below_ellipse", [[
	// Bake some constants into the shader.
	P_POSITION const float LowerX = ]] .. LowerX .. [[;
	P_POSITION const float UpperX = ]] .. UpperX .. [[;
	P_POSITION const float LowerA = ]] .. LowerA .. [[;
	P_POSITION const float LowerB = ]] .. LowerB .. [[;
	P_POSITION const float LowerCenterY = ]] .. LowerCenterY .. [[;
	P_POSITION const float UpperCenterY = ]] .. UpperCenterY .. [[;

	P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
	{
		// Find out at what height, in [0, 1], the pixel lies along the glass. Heights
		// outside this range are culled by the tests further down.
		P_POSITION float t = (uv.y - LowerCenterY) / (UpperCenterY - LowerCenterY);

		// Find the width at this height.
		P_POSITION float w = mix(LowerX, UpperX, t);

		// If the pixel inside this width?
		P_POSITION float x = uv.x - .5;

		if (abs(x) > w) return vec4(0.);

		P_POSITION float x2 = x * x;

		// Is the pixel below the surface ellipse?
		P_POSITION float upper_dy = uv.y - CoronaVertexUserData.x;
		P_POSITION float upper_y2 = upper_dy * upper_dy;

		if (upper_dy < 0. || dot(CoronaVertexUserData.yz, vec2(x2, upper_y2)) <= 1.) return vec4(0.);

		// If the pixel is low, is it in the bottom ellipse?
		P_POSITION float lower_dy = uv.y - LowerCenterY;
		P_POSITION float lower_y2 = lower_dy * lower_dy;

		if (lower_dy > 0. && LowerA * x2 + LowerB * lower_y2 > 1.) return vec4(0.);

		// Then it's in the "liquid" part!
		return CoronaColorScale(texture2D(CoronaSampler0, uv));
	}
]])

-- When the surface is near, but not quite at, the top, the shader that renders its "behind the glass" part --
DefineKernel("intersection_lower", [[
	P_POSITION const float UpperA = ]] .. UpperA .. [[;
	P_POSITION const float UpperB = ]] .. UpperB .. [[;
	P_POSITION const float UpperCenterY = ]] .. UpperCenterY .. [[;

	P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
	{
		// Is the pixel even in the surface ellipse?
		P_POSITION vec2 pos = uv - vec2(.5, CoronaVertexUserData.x);
		P_POSITION vec2 square = pos * pos;

		if (dot(square, CoronaVertexUserData.yz) > 1.) return vec4(0.);

		// Is it also NOT in the "in the open" ellipse?
		P_POSITION vec2 upper_pos = uv - vec2(.5, UpperCenterY);
		P_POSITION vec2 upper_square = upper_pos * upper_pos;

		if (dot(upper_square, vec2(UpperA, UpperB)) <= 1.) return vec4(0.);

		// Then it's in the lower part!
		return CoronaColorScale(texture2D(CoronaSampler0, uv));
	}
]])

-- When the surface is near, but not quite at, the top, the shader that renders its "in the open" part --
DefineKernel("intersection_upper", [[
	P_POSITION const float UpperA = ]] .. UpperA .. [[;
	P_POSITION const float UpperB = ]] .. UpperB .. [[;
	P_POSITION const float UpperCenterY = ]] .. UpperCenterY .. [[;

	P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
	{
		// Is the pixel even in the surface ellipse?
		P_POSITION vec2 pos = uv - vec2(.5, CoronaVertexUserData.x);
		P_POSITION vec2 square = pos * pos;

		if (dot(square, CoronaVertexUserData.yz) > 1.) return vec4(0.);

		// Is it also in the "in the open" ellipse?
		P_POSITION vec2 upper_pos = uv - vec2(.5, UpperCenterY);
		P_POSITION vec2 upper_square = upper_pos * upper_pos;

		if (dot(upper_square, vec2(UpperA, UpperB)) > 1.) return vec4(0.);

		// Then it's in the upper part!
		return CoronaColorScale(texture2D(CoronaSampler0, uv));
	}
]])

-- Our backing image --
local image = display.newImage("orange-juice-in-glass-md.png", display.contentCenterX, display.contentCenterY)

-- Proxy objects, one or more of which get shaded at any given time --
local lower_object = display.newRect(image.x, image.y, image.width, image.height)
local middle_object = display.newRect(image.x, image.y, image.width, image.height)
local upper_object = display.newRect(image.x, image.y, image.width, image.height)

-- Common logic for applying an effect to one of the objects
local function SetEffect (object, name, x, y, b, color)
	object.fill.effect = name

	object.fill.effect.y = y
	object.fill.effect.a = FindConstant(x)
	object.fill.effect.b = b

	object:setFillColor(unpack(color))

	object.isVisible = true
end

-- Slider update logic
local function Update (value)
	local t = value / 100

	-- The x-axis and center y-value increase linearly from bottom to top. The A constant
	-- follows immediately from the x-axis: on the right-hand side, y is 0, so we solve
	-- A * x^2 = 1. We'll need to come up with something for B. We're seeing the glass from
	-- an angle, so B and A vary in proportion to one another; however, by interpolating the
	-- ratio itself we get a perfectly decent result in B = A * Ratio(t).
	local x = LowerX + (UpperX - LowerX) * t
	local y = LowerCenterY + (UpperCenterY - LowerCenterY) * t
	local b = (LowerE + (UpperE - LowerE) * t) * FindConstant(x)

	-- What is the top point of our ellipse?
	-- x will be 0 there, so...
	--   B * (y - Y)^2 = 1
	--   y - Y = +-sqrt(1 / B)
	--   Y = y -+ sqrt(1 / B)
	-- Choose upper of these two.
	local ytop = y - math.sqrt(1 / b)

	-- Liquid is totally behind the glass...
	if ytop > UpperBottom / H then
		middle_object.isVisible = false

		-- Not empty...
		-- Draw a surface and the liquid underneath it.
		if t > 0 then
			SetEffect(lower_object, "filter.custom.below_ellipse", x, y, b, LowerColor)
			SetEffect(upper_object, "filter.custom.inside_ellipse", x, y, b, UpperColor)

		-- ...empty.
		-- Just draw a surface.
		else
			SetEffect(lower_object, "filter.custom.inside_ellipse", x, y, b, UpperColor)

			upper_object.isVisible = false
		end

	-- ...some liquid has passed the front lip.
	else
		SetEffect(lower_object, "filter.custom.below_ellipse", x, y, b, LowerColor)

		-- Not full...
		-- Draw the surface, split into behind-the-glass and in-the-open parts, plus the
		-- liquid underneath it.
		if t < 1 then
			SetEffect(middle_object, "filter.custom.intersection_lower", x, y, b, UpperColor)
			SetEffect(upper_object, "filter.custom.intersection_upper", x, y, b, InOpenColor)

		-- ...full.
		-- Draw a surface (in the open) and the liquid underneath it.
		else
			SetEffect(upper_object, "filter.custom.inside_ellipse", x, y, b, InOpenColor)

			middle_object.isVisible = false
		end
	end
end

-- Add a slider to control our amount of liquid.
local slider = require("widget").newSlider{
	top = 200, left = 50,
	height = 200, orientation = "vertical",
	value = 10,
	listener = function(event)
		Update(event.value)
	end
}

Update(slider.value)