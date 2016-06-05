--- Circles, figure N-4.

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
local A1, CX, CY, R1, to = arc.New(), 80, 100, 120, 310

A1:SetCenter(CX, CY)
A1:SetRadius(R1)
A1:SetAngles(270, to)

local A2 = A1:Clone()

A2:SetAngles(to, to + 30)
A2:SetStyle("dashed")

--
local A3, R2, x, y = arc.New(), 200, A1:GetPos(0)
local dx, dy = x - CX, y - CY
local N = (R1 + R2) / math.sqrt(dx^2 + dy^2)

A3:SetCenter(CX + dx * N, CY + dy * N)
A3:SetRadius(R2)

local join = A3:GetAngleFromPos(x, y)

A3:SetAngles(90, join)

local A4 = A3:Clone()

A4:SetAngles(join, join + 30)
A4:SetStyle("dashed")

--
helpers.Mark(x, y)