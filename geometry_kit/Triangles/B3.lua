--- Triangles, figure B-2.

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

-- --
local CW, CH = display.contentWidth, display.contentHeight
local ToSide = .25 * CW

local RA1, RA2 = triangle.New(), triangle.New()

local rax, ray = .4 * CW, .3 * CH

local function CommonRA (ra, add)
	ra:SetVertexPos(1, rax + add, ray)
	ra:SetVertexPos(2, rax, ray - .2 * CH)
	ra:SetVertexPos(3, rax, ray)
	ra:SetSideStyle(1, "hide")
	ra:MarkAngle(3, 1, { angle_offset = .2 })
end

CommonRA(RA1, -ToSide)
CommonRA(RA2, ToSide)

local Supp1, Supp2 = triangle.New(), triangle.New()

local suppx, suppy = .6 * CW, .7 * CH

local function CommonSupp (supp, add)
	supp:SetVertexPos(1, suppx + add, suppy)
	supp:SetVertexPos(2, suppx + .25 * CW, suppy - .15 * CH)
	supp:SetVertexPos(3, suppx, suppy)
	supp:SetSideStyle(1, "hide")
	supp:MarkAngle(3, add > 0 and 2 or 1, { angle_offset = .2, angle_spacing = .075 })
end

CommonSupp(Supp1, -ToSide)
CommonSupp(Supp2, ToSide)

return { RA1 = RA1, RA2 = RA2, Supp1 = Supp1, Supp2 = Supp2 } -- reused by figure 7