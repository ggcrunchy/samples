--- Triangle area, figure A-2.

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

--
local CW, CH = display.contentWidth, display.contentHeight
local BottomY = .75 * CH
local MidY = .5 * CH
local TopY = .25 * CH
local LeftX = .2 * CW
local RightX = .8 * CW

local U = triangle.New()

U:SetVertexPos(1, LeftX, MidY)
U:SetVertexPos(2, RightX, MidY)
U:SetVertexPos(3, RightX, TopY)
U:MarkSide(1, 1)
U:MarkSide(2, 2)

U:MarkAngle(1, 1, { angle_offset = .2 })
U:MarkAngle(2, 1, { angle_offset = .15 })
U:MarkAngle(3, 2, { angle_offset = .1 })

local T = triangle.New()

T:SetVertexPos(1, LeftX, MidY)
T:SetVertexPos(2, RightX, TopY)
T:SetVertexPos(3, LeftX, TopY)

T:MarkAngle(1, 2, { angle_offset = .1 })
T:MarkAngle(2, 1, { angle_offset = .2 })
T:MarkAngle(3, 1, { angle_offset = .15 })
T:MarkSide(2, 1)
T:MarkSide(3, 2)
T:SetSideStyle(1, "hide")