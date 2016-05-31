--- Circles, figure C-4.

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
local helpers = require("helpers")
local C2 = require("Circles.C2")

--
local yshift = 50
local x1, y1 = C2.T:GetVertexPos(1)

y1 = y1 + yshift

C2.A:SetCenter(x1, y1)
C2.T:Translate(0, yshift)

C2.T:LabelSide(1, nil)
C2.T:LabelSide(2, nil)
C2.T:LabelSide(3, nil)

local U = C2.T:Clone()

C2.T:MarkAngle(3, nil)

U:LabelAngle(1, nil)
U:MarkAngle(1, nil)
U:Scale(1 / math.cos(C2.T:GetAngle(1)))

local x2, y2 = U:GetVertexPos(1)

U:Translate(x1 - x2, y1 - y2)

for i = 1, 3 do
	U:SetSideStyle(i, "dashed")
end

U:LabelSide(1, "secθ", { align = true })
U:LabelSide(2, "tanθ", { align = true, text_offset = 20 })

helpers.PutRotatedObjectBetween(U:GetSideLabel(1), U:GetVertexPos(1), U:GetVertexPos(2), { margin = -4 })