--- Centers, figure D-3.

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
local centers = require("centers")
local helpers = require("helpers")
local math2d_ex = require("math2d_ex")
local triangle = require("triangle")

--
local scale, xshift, yshift = 2.7, -115, 50
local px, py = 160 + xshift, 310 + yshift
local qx, qy = px + (110 + xshift - px) * scale, py + (250 + yshift - py) * scale
local rx, ry = px + (210 + xshift - px) * scale, py + (260 + yshift - py) * scale

--
local circles, contacts = centers.Excircles(px, py, qx, qy, rx, ry, true)
local circ, contact = circles[3], contacts[3]

local T = triangle.New()

T:SetVertexPos(1, contact.b.x, contact.b.y)
T:SetVertexPos(2, contact.a.x, contact.a.y)
T:SetVertexPos(3, rx, ry)

T:LabelAngle(1, "α", { radius = 55, size = 20, angle_time = .6 })
T:LabelAngle(2, "α", { radius = 55, size = 20, angle_time = .45 })
T:MarkSide(2, 1)
T:MarkSide(3, 1)

--
local vx, vy = math2d_ex.ProjectOnto(contact.a.x - contact.b.x, contact.a.y - contact.b.y, rx - contact.b.x, ry - contact.b.y)
local U = triangle.New()

U:SetVertexPos(1, rx, ry)
U:SetVertexPos(2, contact.a.x, contact.a.y)
U:SetVertexPos(3, contact.b.x + vx, contact.b.y + vy)

U:SetSideStyle(1, "hide")
U:SetSideStyle(2, "dashed")
U:SetSideStyle(3, "dashed")
U:LabelAngle(1, "2α", { radius = 38, angle_time = .45, size = 22 })
U:MarkAngle(3, 1, { angle_offset = .15 })

--
helpers.Mark(contact.b.x, contact.b.y):setFillColor(0, 0, 1)
helpers.Point(rx, ry, 7)