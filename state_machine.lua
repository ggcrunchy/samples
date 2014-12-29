--- Simple (contrived!) case where a state machine could be better served by coroutines.

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
do
	local state, rect = "starting"

	Runtime:addEventListener("enterFrame", function()
		if state == "starting" then
			rect = display.newRect(100, 100, 50, 50)

			transition.to(rect, {
				x = 300,

				onComplete = function()
					print("Waiting...")

					state = "wait"
				end
			})

			state = nil

		elseif state == "wait" then
			timer.performWithDelay(1000, function()
				print("Time's up!")

				transition.to(rect, { time = 1500, y = 400 })

				state = "wait_for_y"
			end)

			state = nil

		elseif state == "wait_for_y" then
			if rect.y >= 200 then
				print("Passed 200")

				rect:setFillColor(0, 0, 1)

				state = nil
			end
		end
	end)
end
--]]

--[[
local EventListener

EventListener = coroutine.wrap(function()
	local rect, done = display.newRect(100, 100, 50, 50)

	transition.to(rect, {
		x = 300,

		onComplete = function()
			done = true
		end
	})

	wait.WaitUntilTrue(function()
		return done
	end)

	print("Waiting...")

	wait.WaitMS(1000)

	print("Time's up!")

	transition.to(rect, { time = 1500, y = 400 })

	wait.WaitUntilTrue(function()
		return rect.y >= 200
	end)

	print("Passed 200")

	rect:setFillColor(0, 0, 1)

	Runtime:removeEventListener("enterFrame", EventListener)
end)

Runtime:addEventListener("enterFrame", EventListener)
--]]