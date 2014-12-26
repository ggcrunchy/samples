--- Hilbert curve, see: http://www.hackersdelight.org/hdcodetxt/hilbert/hilgen2.c.txt

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

--
local function AuxHilbert (order, dir, rot, step)
	order = order - 1

	if order >= 0 then
		dir = dir + rot

		AuxHilbert(order, dir, -rot, step)
		step(dir)

		dir = dir - rot
		
		AuxHilbert(order, dir, rot, step)
		step(dir)
		AuxHilbert(order, dir, rot, step)

		dir = dir - rot

		step(dir)
		AuxHilbert(order, dir, -rot, step)
	end
end

local Ways = { "right", "down", "left", "up" }

local function ForEach (order, func)
	local x, y, s = -1, 0, 0

	local function step (dir)
		dir = dir % 4

		if dir == 0 or dir == 2 then
			x = x + 1 - dir
		else
			y = y + 2 - dir
		end

		func(s, x, y, Ways[dir + 1])

		s = s + 1
	end

	step(0)
	AuxHilbert(order, 0, 1, step)
end

local line, x1, y1

timer.performWithDelay(3, coroutine.wrap(function(event)
	ForEach(6, function(_, x, y, _)
		local wx, wy = 30 + x * 7, 450 - y * 7

		if line then
			line:append(wx, wy)
		elseif x1 then
			line = display.newLine(x1, y1, wx, wy)
		else
			x1, y1 = wx, wy
		end

		coroutine.yield()
	end)

	timer.cancel(event.source)
end), 0)