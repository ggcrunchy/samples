--- Circles, figure Q-2.

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

--
local MidX = display.contentCenterX
local BottomY, TopY = 250, 150
local BottomW, TopW = 120, 240
local BottomLeftX, TopLeftX = MidX - BottomW / 2, MidX - TopW / 2
local BottomRightX, TopRightX = BottomLeftX + BottomW, TopLeftX + TopW

--
helpers.HLine(BottomLeftX, BottomRightX, BottomY)
helpers.HLine(TopLeftX, TopRightX, TopY)
helpers.Line(BottomLeftX, BottomY, TopLeftX, TopY, true)
helpers.Line(BottomRightX, BottomY, TopRightX, TopY, true)

--
helpers.TextBetween("2πr2", TopLeftX, TopRightX, TopY - 20, { margin = 3 })
helpers.TextBetween("2πr1", BottomLeftX, BottomRightX, BottomY + 20)

--
helpers.VLine(MidX, TopY + 10, BottomY - 10)
helpers.HLine(MidX - 10, MidX + 10, TopY + 10)
helpers.HLine(MidX - 10, MidX + 10, BottomY - 10)
helpers.Text("r2 - r1", MidX + 32, (BottomY + TopY) / 2, { size = 18 })