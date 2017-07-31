--- Triangles, figure I-5.

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

local CW, CH = display.contentWidth, display.contentHeight
local BottomY = .65 * CH
local MidY = .4 * CH
local TopY = .25 * CH
local LeftX = .05 * CW
local RightX = .95 * CW
local MidX = LeftX + (MidY - BottomY) * (RightX - LeftX) / (TopY - BottomY)

--
local T = triangle.New()

T:SetVertexPos(1, LeftX, BottomY)
T:SetVertexPos(2, MidX, MidY)
T:SetVertexPos(3, MidX, BottomY)

T:SetSideStyle(2, "dashed")
T:LabelAngle(1, "D", { angle_time = .45, radius = 47 })
T:LabelAngle(2, "S", {  })
T:MarkAngle(3, 1)

local U = triangle.New()

U:SetVertexPos(1, MidX, MidY)
U:SetVertexPos(2, RightX, TopY)
U:SetVertexPos(3, MidX, BottomY)

U:LabelAngle(1, "A", { radius = 15 })
U:LabelAngle(2, "B", { angle_time = .55, radius = 60 })
U:LabelAngle(3, "C", { radius = 55 })
U:SetSideStyle(3, "hide")