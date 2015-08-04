--- Showing the wait operations in use.

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

local wait = require("wait")

---[[
-- Wait in a timer:
timer.performWithDelay(20, coroutine.wrap(function(event)
	local source = event.source -- GOTCHA: save this now!

	wait.WaitMS(3000)

	print("Time's up!")

	wait.WaitMS(3000)

	print("Time's up 2!")

	wait.WaitMS(3000)

	print("Time's up 3!")

	timer.cancel(source)
end), 0)
--]]

--[[
-- Wait in a timer, doing something at the same time.
do
	local rect, color_timer = display.newRect(100, 100, 50, 50)

	color_timer = timer.performWithDelay(20, coroutine.wrap(function(event)
		wait.WaitMS(3000, function()
			rect:setFillColor(math.random(), math.random(), math.random())
		end)

		print("All done!")

		timer.cancel(color_timer)
	end), 0)
end
--]]

--[[
-- Wait for something to happen.
do
	local rect = display.newRect(100, 100, 50, 50)

	timer.performWithDelay(20, coroutine.wrap(function(event)
		local source = event.source

		wait.WaitUntilTrue(function()
			return rect.y > 300
		end)

		print("Halfway there!")

		timer.cancel(source)
	end), 0)

	transition.to(rect, { y = 500, time = 1500 })
end
--]]

--[[
-- Wait for some property to become true.
-- For variety, let's use a Runtime listener instead of a timer.
do
	local rect = display.newRect(100, 100, 50, 50)
	local circle = display.newCircle(200, 200, 10)

	circle.isVisible = false

	local body

	body = coroutine.wrap(function()
		wait.WaitUntilPropertyTrue(circle, "isVisible")

		print("Circle is visible!")

		Runtime:removeEventListener("enterFrame", body)
	end)

	Runtime:addEventListener("enterFrame", body)

	transition.to(rect, {
		y = 500, time = 1500,

		onComplete = function()
			circle.isVisible = true
		end
	})
end
--]]