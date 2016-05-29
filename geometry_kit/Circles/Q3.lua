--- Circles, figure Q-3.

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
local helpers = require("helpers")
local triangle = require("triangle")

--
local MidX = display.contentCenterX
local BottomY, TopY = 250, 150
local BottomW, TopW = 250, 140
local BottomLeftX, TopLeftX = MidX - BottomW / 2, MidX - TopW / 2
local BottomRightX, TopRightX = BottomLeftX + BottomW, TopLeftX + TopW - 20


helpers.HLine(BottomLeftX, BottomRightX, BottomY)
helpers.HLine(TopLeftX, TopRightX, TopY)

--
helpers.TextBetween("w1", TopLeftX, TopRightX, TopY - 20, { margin = 3 })
helpers.TextBetween("w2", BottomLeftX, BottomRightX, BottomY + 50)

--
local T1 = triangle.New()

T1:SetVertexPos(1, BottomLeftX, BottomY)
T1:SetVertexPos(2, TopLeftX, TopY)
T1:SetVertexPos(3, TopLeftX, BottomY)

T1:SetSideStyle(2, "dashed")
T1:SetSideStyle(3, "hide")
T1:MarkAngle(3, 1, { angle_offset = .2 })

local T2 = triangle.New()

T2:SetVertexPos(1, TopRightX - 1, TopY - 1)
T2:SetVertexPos(2, BottomRightX, BottomY)
T2:SetVertexPos(3, TopRightX - 1, BottomY)

T2:SetSideStyle(2, "hide")
T2:SetSideStyle(3, "dashed")
T2:MarkAngle(3, 1, { angle_offset = .125 })

--
helpers.TextBetween("b1", BottomLeftX, TopLeftX - .5, BottomY + 20)
helpers.TextBetween("b2", TopRightX - .5, BottomRightX, BottomY + 20)