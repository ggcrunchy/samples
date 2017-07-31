--- Circles, figure M-4.

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
local R1, R2 = math.sqrt(DXL^2 + h^2), math.sqrt(DXR^2 + h^2)

--
local A1 = arc.New()

A1:SetCenter(x - R1, y)
A1:SetRadius(R1)

--
local A2 = arc.New()

A2:SetCenter(x + R2, y)
A2:SetRadius(R2)

--
helpers.HLine(x - R1, x + R2, y, true)

helpers.Point(A1:GetCenter()).path.radius = 4
helpers.Point(A2:GetCenter()).path.radius = 4

helpers.Mark(x, y)