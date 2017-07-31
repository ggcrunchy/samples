--- Circles, figure M-2.

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
local x, y, h = 180, 200, 30
local DXL, DXR = 70, 40
local y1, y2 = y - h, y + h

--
local AL = arc.New()

AL:SetCenter(x - DXL, y)
AL:SetRadius(math.sqrt(DXL^2 + h^2))

local al = AL:GetAngleFromPos(x, y1)

AL:SetAngles(al, 360 - al)
AL:SetStyle("dashed")

--
local AR = arc.New()

AR:SetCenter(x + DXR, y)
AR:SetRadius(math.sqrt(DXR^2 + h^2))

local ar = AR:GetAngleFromPos(x, y2)

AR:SetAngles(ar, 360 - ar)
AR:SetStyle("dashed")

--
helpers.Line(x - DXL, y, x, y1)
helpers.Line(x, y1, x + DXR, y)
helpers.Line(x, y2, x + DXR, y)
helpers.Line(x - DXL, y, x, y2)

--
helpers.Point(x - DXL, y).path.radius = 4
helpers.Point(x + DXR, y).path.radius = 4