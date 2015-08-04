--- A demo showing multi-pass effects.

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

local Size = 10

do
	-- Kernel --
	local kernel = { category = "filter", name = "move" }

	kernel.vertexData = {
		{
			name = "light_angle",
			default = 0, min = -2 * math.pi, max = 2 * math.pi,
			index = 0
		}
	}

	-- Simple position change
	kernel.vertex = [[
		P_POSITION vec2 VertexKernel (P_POSITION vec2 position)
		{
			P_UV vec2 diff = vec2(cos(CoronaVertexUserData.x), sin(CoronaVertexUserData.x)); // x = light angle

			position -= diff * ]] .. ("%.2f"):format(Size / 2) .. [[;

			return position;
		}
	]]

	-- Tint the shadow with the screen position
	kernel.fragment = [[
		P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
		{
			P_COLOR vec4 color = texture2D(CoronaSampler0, uv);
			P_COLOR float angle = sin(CoronaVertexUserData.x * 5.1) * .5 + .5;

			return vec4((1. - color.rgb) * vec3(angle, gl_FragCoord.xy * CoronaTexelSize.xy), 1.) * color.a;
		}
	]]

	graphics.defineEffect(kernel)
end

do
	-- Kernel --
	local kernel = { category = "filter", name = "blur_move" }

	kernel.graph = {
---[[
	   nodes = {
		  blur = { effect = "filter.blurGaussian", input1 = "paint1" },
		  move = { effect = "filter.custom.move", input1 = "blur" },
	   }, output = "move"
--]]
--[[
	-- Doesn't work? 
	   nodes = {
		  blur = { effect = "filter.blurGaussian", input1 = "move" },
		  move = { effect = "filter.custom.move", input1 = "paint1" },
	   }, output = "blur"
--]]
	}

	graphics.defineEffect(kernel)
end

local Scale = .3

timer.performWithDelay(300, function()
	local cx, w = display.contentCenterX, display.contentWidth
	local cy, h = display.contentCenterY, display.contentHeight

	local background = display.newRect(cx, cy, w, h)

	background:setFillColor(0.6, 0.6, 0.8)

	-- object we want to be with shadow
	local ball = display.newImage('Toon-Up.png', cx, cy)

	ball.xScale, ball.yScale = Scale, Scale

	-- shadow object
	local ballshadow = display.newImage('Toon-Up.png', cx, cy)

	ballshadow:setFillColor(0) -- it fills our obj with black colour not touching the background of the image

	ballshadow.xScale, ballshadow.yScale = Scale, Scale

	-- here's a trick for fill.effect, we just make shadow-image's canvas bigger
	local r = display.newRect(ballshadow.x, ballshadow.y, ballshadow.contentWidth * 2, ballshadow.contentHeight * 2)

	r:setFillColor(0, 0)

	-- take black obj with extended canvas into the group
	local g = display.newGroup()

	g:insert(r)
	g:insert(ballshadow)

	-- turn a groupObj into a displayObj	
	local c = display.capture(g) 
	local light = display.newCircle(cx + 200, cy, 15)

	-- Normal parameters.
	c.alpha = 0.7

	c.x = ballshadow.x 
	c.y = ballshadow.y 

	-- apply blur filter and set alpha    
	c.fill.effect = "filter.custom.blur_move"

	-- Blur part.
	c.fill.effect.blur.horizontal.blurSize = Size
	c.fill.effect.blur.horizontal.sigma = 128
	c.fill.effect.blur.vertical.blurSize = Size
	c.fill.effect.blur.vertical.sigma = 128

	-- Move part.
	c.fill.effect.move.light_angle = 0

	-- Clean up and get things in order.
	g:removeSelf()
	c:toBack()
	background:toBack()

	-- Update!
	Runtime:addEventListener("enterFrame", function(event)
		local seconds = event.time / 1000
		local light_angle = math.rad((seconds * 35) % 360)

		light.x, light.y = cx + 200 * math.cos(light_angle), cy + 200 * math.sin(light_angle)

		local object_angle = (-seconds * 20) % 360

		ball.rotation, c.rotation = object_angle, object_angle

		c.fill.effect.move.light_angle = light_angle
	end)
end)