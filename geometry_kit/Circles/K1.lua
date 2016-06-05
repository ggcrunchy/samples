--- Circles, figure K-1.

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

-- Plugins --
local math2d = require "plugin.math2d"

--
local A = arc.New()
local CX, CY = 150, 200

A:SetCenter(CX, CY)
A:SetRadius(40)
A:SetAngles(25, 25)

local x1, y1 = A:GetPos(0)
local nx, ny = math2d.normalize(x1 - CX, y1 - CY)

A:SetAngles(0, 360)

--
helpers.Line(x1 - nx * 10, y1 - ny * 10, x1 + nx * 10, y1 + ny * 10)

--
local x2, y2 = x1 - 50, y1 + 150
local dx, dy = x2 - CX, y2 - CX

helpers.Arrow(CX + dx * .3, CY + dy * .3, x2, y2, { t = .8 }):setStrokeColor(.1, .5)

--
local x3, y3, len = x2 + dx * .1, y2 + dy * .1, 2 * math.pi * A:GetRadius()
local a, b = .35 * len, .65 * len
local vx, vy = math2d.normalize(30, -10)
local x4, y4 = x3 - a * vx, y3 - a * vy
local x5, y5 = x3 + b * vx, y3 + b * vy

helpers.Line(x4, y4, x5, y5)
