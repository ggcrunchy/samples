--- Circles, figure C-1.

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
local triangle = require("triangle")

--
local T = triangle.New()

T:SetVertexPos(1, 50, 220)
T:SetVertexPos(2, 170, 95)
T:SetVertexPos(3, 170, 220)

T:LabelAngle(1, "θ")
T:MarkAngle(1, 1, { angle_offset = .125 })
T:MarkAngle(3, 1, { angle_offset = .125 })
T:LabelSide(1, "r", { align = true })
T:LabelSide(2, "r sinθ", { text_offset = 50 })
T:LabelSide(3, "r cosθ")

local A = arc.New()

A:Revolve(T)
A:SetAngles(0, 90)
A:SetStyle("dashed")

return { A = A, T = T }