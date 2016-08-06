--- Centers, figure C-4.

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
local centers = require("centers")
local helpers = require("helpers")
local triangle = require("triangle")

-- Plugins --
local math2d = require("plugin.math2d")

--
local xshift = 35
local x1, y1, scale = 180 + xshift, 80, 1.8
local x2, y2 = x1 + (240 + xshift - x1) * scale, y1 + (270 - y1) * scale
local x3, y3 = x1 + (60 + xshift - x1) * scale, y1 + (190 - y1) * scale
local cx, cy, r, contact = centers.Incircle(x1, y1, x2, y2, x3, y3, true)
local mx, my = (contact.c.x + contact.a.x) / 2, (contact.c.y + contact.a.y) / 2

--
local T1 = triangle.New()

T1:SetVertexPos(1, contact.c.x, contact.c.y)
T1:SetVertexPos(2, x1, y1)
T1:SetVertexPos(3, mx, my)

T1:SetSideStyle(1, "hide")
T1:SetSideStyle(2, "hide")
T1:SetSideStyle(3, "dashed")

--
local T2, offset = triangle.New(), 24

T2:SetVertexPos(1, T1:GetVertexPos(1))
T2:SetVertexPos(2, T1:GetVertexPos(2))
T2:SetVertexPos(3, cx, cy)

T2:LabelSide(3, "r", { text_offset = 14 })
T2:LabelSide(2, "r·secβ", { align = true, text_offset = offset })
T2:LabelAngle(3, "β", { angle_time = .4 })
T2:MarkAngle(1, 1, { angle_offset = .125 })

local label = T2:GetSideLabel(2)
local half, angle = label.width / 2, math.rad(label.rotation)
local h, ca, sa = half + 5, math.cos(angle), math.sin(angle)
local sx1, sy1 = cx + sa * offset, cy - ca * offset
local sx2, sy2 = x1 + sa * offset, y1 - ca * offset

helpers.Line(label.x + h * ca, label.y + h * sa, sx1, sy1)
helpers.Line(label.x - h * ca, label.y - h * sa, sx2, sy2)
helpers.Line(sx1 - sa * 10, sy1 + ca * 10, sx1 + sa * 10, sy1 - ca * 10)
helpers.Line(sx2 - sa * 10, sy2 + ca * 10, sx2 + sa * 10, sy2 - ca * 10)

--
helpers.Mark(mx, my)
helpers.Mark(cx, cy)
helpers.Point(x1, y1, 7)
helpers.Text("q", x1 + 5, y1 - 20)