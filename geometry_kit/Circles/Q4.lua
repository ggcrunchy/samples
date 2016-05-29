--- Circles, figure Q-4.

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
local CX, CY, R = display.contentCenterX, display.contentCenterY, 35
local TopW = 2 * math.pi * R
local TopLeftX = CX - TopW / 2
local TopRightX = TopLeftX + TopW

--
local slope = math.pi

for i = 0, 2 do
	local dy = i * R / 3
	local trx, y = TopRightX - dy * slope, CY + dy

	helpers.HLine(TopLeftX + dy * slope, trx, y + i * .5)
	helpers.Text("r" .. (3 - i), trx + 5, y + 15, { size = 15 })
end

--
helpers.Line(TopLeftX, CY, CX, CY + R)
helpers.Line(TopRightX, CY, CX, CY + R)

--
helpers.VLine(TopLeftX - 25, CY, CY + R)
helpers.HLine(TopLeftX - 35, TopLeftX - 15, CY)
helpers.HLine(TopLeftX - 35, TopLeftX - 15, CY + R)
helpers.Text("r", TopLeftX - 10, CY + R / 2)

--
helpers.TextBetween("2πr", TopLeftX, TopRightX, CY - 15)