--- Centers, figure C-3.

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
local xshift = 55
local x1, y1, scale = 180 + xshift, 80, 2.6
local x2, y2 = x1 + (240 + xshift - x1) * scale, y1 + (270 - y1) * scale
local x3, y3 = x1 + (60 + xshift - x1) * scale, y1 + (190 - y1) * scale
local cx, cy, r, contact = centers.Incircle(x1, y1, x2, y2, x3, y3, true)
local mx, my = (contact.c.x + contact.a.x) / 2, (contact.c.y + contact.a.y) / 2

--
local T1 = triangle.New()

T1:SetVertexPos(1, contact.c.x, contact.c.y)
T1:SetVertexPos(2, x1, y1)
T1:SetVertexPos(3, mx, my)

T1:LabelSide(1, "A'", { align = true, text_offset = 15 })
T1:LabelSide(2, "V", { align = true, text_offset = 15 })
T1:LabelSide(3, "H", { align = true, text_offset = -14, t = .4 })
T1:LabelAngle(1, "β", { angle_time = .55 })
T1:LabelAngle(2, "α", { radius = 40 })
T1:MarkAngle(3, 1, { angle_offset = .175 })

local hlabel, vlabel = T1:GetSideLabel(3), T1:GetSideLabel(2)

vlabel.rotation = vlabel.rotation - 90

hlabel:setTextColor(.25)
vlabel:setTextColor(.25)

--
local T2 = triangle.New()

T2:SetVertexPos(1, T1:GetVertexPos(1))
T2:SetVertexPos(2, mx, my)
T2:SetVertexPos(3, cx, cy)

T2:SetSideStyle(1, "hide")
T2:LabelSide(3, "r", { text_offset = 14 })
T2:LabelAngle(1, "α", { angle_time = .6, radius = 40 })
T2:LabelAngle(3, "β", { angle_time = .4 })

--
local R = triangle.New()

R:SetVertexPos(1, x1, y1)
R:SetVertexPos(2, contact.a.x, contact.a.y)
R:SetVertexPos(3, cx, cy)

R:SetSideStyle(1, "dashed")
R:SetSideStyle(2, "dashed")
R:SetSideStyle(3, "hide")

--
local lx, ly = math2d.normalize(contact.c.x - x1, contact.c.y - y1)
local L, side = triangle.New(), 80

L:SetVertexPos(1, contact.c.x + lx * side, contact.c.y + ly * side)
L:SetVertexPos(2, contact.c.x, contact.c.y)
L:SetVertexPos(3, cx, cy)

L:SetSideStyle(1, "dashed")
L:SetSideStyle(2, "hide")
L:SetSideStyle(3, "hide")
L:MarkAngle(2, 1, { angle_offset = .15 })

--
helpers.Mark(mx, my):setFillColor(0, 0, 1)
helpers.Mark(cx, cy):setFillColor(1, 0, 0)
helpers.Point(x1, y1, 7)
helpers.Text("m", mx + 18, my + 5, 23)
helpers.Text("q", x1 + 5, y1 - 20)