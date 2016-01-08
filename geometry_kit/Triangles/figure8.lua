--- Triangles, figure 8.

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
local angle = require("angle")
local triangle = require("triangle")
local figure1 = require("Triangles.figure1")

-- Plugins --
local math2d = require "plugin.math2d"

local dup = figure1:Clone()

figure1:LabelAngle(3, nil)
figure1:LabelSide(2, nil)
figure1:LabelSide(3, nil)

figure1:SetSideStyle(2, "hide")
figure1:SetSideStyle(3, "hide")

dup:LabelAngle(1, nil)
dup:LabelAngle(2, nil)
dup:LabelSide(1, nil)

local vprev, corner, vnext = dup:GetPrev(3), dup[3], dup:GetNext(3)
local axes = angle.GetAxes(vprev, corner, vnext)
local len1, len2 = math2d.length(math2d.sub(vprev, corner, true)), math2d.length(math2d.sub(vnext, corner, true))

axes:SetPosition(corner.x, corner.y)

axes:SetRadius(len2)
dup:SetVertexPos(1, axes:GetPosAtParameter(-.1))
axes:SetRadius(len1)
dup:SetVertexPos(2, axes:GetPosAtParameter(1.1))
dup:LabelAngle(3, "C'", { radius = 45 })

dup:SetSideStyle(1, "hide")