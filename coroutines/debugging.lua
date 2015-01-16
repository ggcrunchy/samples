--- Using coroutines as a debugging aid.

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

local P

local function AddItems ()
	local red = display.newRect(100, 100, 30, 70)

	red:setFillColor(1, 0, 0)

	P("Added red rect")

	local blue = display.newCircle(150, 30, 10)

	blue:setFillColor(0, 0, 1)

	P("Added blue circle")

	local green = display.newRect(200, 100, 60, 20)

	green:setFillColor(0, 1, 0)

	P("Added green rect")
end

---[[
-- Debug with print
P = print

AddItems()
--]]

--[[
-- Debug by stepping through with a coroutine.
P = coroutine.yield

local co = coroutine.create(AddItems)

local button = display.newCircle(20, 20, 10)

button:setFillColor(.7)
button:addEventListener("touch", function(event)
	if event.phase == "began" and coroutine.status(co) == "suspended" then
		coroutine.resume(co)
	end

	return true
end)
--]]