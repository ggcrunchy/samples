--- Finishing off the basic coroutine cases.

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

---[[
do
	-- What does coroutine.yield() do?
	print("Let's try doing a yield!")

	local co = coroutine.create(function()
		print("Inside the coroutine!")

		coroutine.yield()

		print("I'm back!")
	end)

	coroutine.resume(co)

	print("Status after a yield: ", coroutine.status(co))
	print("Let's try to resume, then.")

	coroutine.resume(co)

	print("Status after second resume: ", coroutine.status(co))
end
--]]

--[[
do
	-- What does resume do if we pass arguments through yield?
	print("Trying something: passing arguments to yield")

	local co = coroutine.create(function()
		print("Starting coroutine")

		coroutine.yield(5, 21, {}, "B")
	end)

	print("Yielding with arguments gives: ", coroutine.resume(co))
end
--]]

--[[
do
	-- What if we pass in arguments to resume?
	print("Trying something else: passing arguments to resume")

	local co = coroutine.create(function(...)
		print("Starting coroutine, args: ", ...)

		for i = 1, 3 do
			print("Yield received: ", coroutine.yield(i))
		end

		return 1, 2, 3
	end)

	local arg1, arg2 = "A", "B"

	repeat
		arg1 = arg1 .. "+"
		arg2 = arg2 .. "7"

		print("Resume gives: ", coroutine.resume(co, arg1, arg2))
	until coroutine.status(co) == "dead"
end
--]]

--[[
do
	-- What does coroutine.wrap() do?
	print("Let's try wrapping a coroutine!")

	local wrapped = coroutine.wrap(function(arg)
		print("Argument: ", arg)
		print("Yield gives: ", coroutine.yield("D"))

		return "E"
	end)

	print("Calling wrapper: ", wrapped("A"))
	print("Calling again: ", wrapped("B"))
--	print("And once more: ", wrapped("C")) -- Dead: crash!
end
--]]