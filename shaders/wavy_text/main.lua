--- Shader-based example for updating some text geometry.

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

-- Kernel --
local kernel = { category = "filter", name = "wavy_text" }

kernel.isTimeDependent = true

kernel.vertex = [[
	P_POSITION vec2 VertexKernel (P_POSITION vec2 pos)
	{
		P_POSITION float offset = sin(CoronaTexCoord.x * 3.7 + CoronaTotalTime * 8.2);

		pos.y += offset * 8.7;

		return pos;
	}
]]

kernel.fragment = [[
	P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
	{
		return texture2D(CoronaSampler0, uv) * vec4(uv.x, 0., 0., 1.);
	}
]]

graphics.defineEffect(kernel)

local x = -600

local verts = {}

for i = 1, 20 do
	verts[#verts + 1] = x
	verts[#verts + 1] = -100

	x = x + 30
end

for i = 1, 20 do
	x = x - 30

	verts[#verts + 1] = x
	verts[#verts + 1] = 100
end

local polygon = display.newPolygon(display.contentCenterX, display.contentCenterY, verts)

local paint = {
    type = "image",
    filename = "Text.png" 
}

polygon.fill = paint

polygon.fill.effect = "filter.custom.wavy_text"
--[[
local physics = require("physics")
physics.setGravity(0,0)
physics.addBody(polygon, "kinematic")]]
display.setDrawMode("wireframe", true)