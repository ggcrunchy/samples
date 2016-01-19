--- Triangles, figure B-3.

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

-- Modules --
local triangle = require("triangle")
local figure6 = require("Triangles.B2")

--
figure6.RA1:Remove()
figure6.RA2:Remove()

local CW, CH = display.contentWidth, display.contentHeight
local MidX, MidY = figure6.Supp1:GetVertexPos(3)
local ToSide = figure6.Supp2:GetVertexPos(1) - MidX

local Vert1, Vert2 = triangle.New(), triangle.New()

local function CommonVert (vert, add)
	vert:SetVertexPos(1, MidX - add, MidY)
	vert:SetVertexPos(2, MidX - .25 * CW, MidY + .15 * CH)
	vert:SetVertexPos(3, MidX, MidY)
	vert:SetSideStyle(1, "hide")
	vert:MarkAngle(3, add > 0 and 2 or 1, { angle_offset = .2, angle_spacing = .075 })
end

CommonVert(Vert1, -ToSide)
CommonVert(Vert2, ToSide)