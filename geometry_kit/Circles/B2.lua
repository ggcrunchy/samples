--- Circles, figure B-2.

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
local arc = require("arc")
local helpers = require("helpers")

--
local A = arc.New()

A:SetCenter(160, 200)
A:SetRadius(70)

--
helpers.Point(A:GetCenter()).path.radius = 4

--
for i, text in ipairs{
	{ "x = +r", "y = 0", 40, 0 },
	{ "x = 0", "y = -r", 0, 35 },
	{ "x = -r", "y = 0", -40, 0 },
	{ "x = 0", "y = +r", 0, -35 }
} do
	local x, y = A:GetPos((i - 1) / 4)

	helpers.Text(text[1], x + text[3], y + text[4] - 10, { size = 15 })
	helpers.Text(text[2], x + text[3], y + text[4] + 10, { size = 15 })

	helpers.Mark(x, y).path.radius = 4
end