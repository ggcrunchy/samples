--- Curl, figure 2.

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

--- Modules --
local arc = require("arc")
local helpers = require("helpers")

--
local A = arc.New()

A:SetRadius(40)
A:SetCenter(100, 300)
A:SetAngles(270, 90)

local R, x1, y1 = A:GetRadius(), A:GetPos(1)
local x2, y2 = A:GetPos(0)

helpers.Line(x1 + 1, y1 + 1, x1 - 70, y1 + 1)

local X, Y, D = 30, 25, math.pi * R
local w = R + Y + D

helpers.Line(x2, y2, x2 - X, y2)

--
helpers.TextBelow("D", x2 - X + .5, x2 + w, y2 - 40, -15, { size = 18 })
helpers.TextBelow("A", x2 - X + .5, x2, y2, -15, { size = 18 })
helpers.TextBelow_Multi({
	"R", x1 + R,
	"B", x1 + R + Y,
	"πR", x1 + w
}, x1, y1, 13, { size = 18, line_style = "dashed" })