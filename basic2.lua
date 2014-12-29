--- Further basic coroutine cases.

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
	-- Let's try another one.
	local co = coroutine.create(function()
		print("We're back inside a coroutine!")
	end)

	-- Let's see what we get!
	print("Let's see what resume gives us for a live coroutine.")

	print(coroutine.resume(co))

	print("Status after resume: ", coroutine.status(co))
end
--]]

--[[
do
	-- Hmm, not very helpful. What if we returned something?
	print("Let's make another coroutine and try something else")

	local co = coroutine.create(function()
		print("And again!")

		return 3, 7
	end)

	print("Resuming again gives: ", coroutine.resume(co))
end
--]]

--[[
do
	-- Hmm, it returns values... maybe it takes arguments?
	print("Let's try passing arguments!")

	local co = coroutine.create(function(a, b, c)
		print("And a third time!")
		print("ARGUMENTS: ", a, b, c)
	end)

	coroutine.resume(co, 1, 2)
end
--]]

--[[
do
	-- What if it crashes?
	print("Let's see what happens if there's an error!")

	local co = coroutine.create(function()
		print("So far so good...")

		J[7] = 8

		print("Got here?")
	end)

	print("Resuming, but running into an error gives: ", coroutine.resume(co))
	print("And our status now is: ", coroutine.status(co))
end
--]]

--[[
do
	-- Let's see what the status is INSIDE the coroutine.
	local co -- recursion sugar is not quite enough to capture this, so forward declare

	co = coroutine.create(function()
		print("I'm inside the coroutine and...")
		print("...its status is: ", coroutine.status(co)) -- gives "running"

		-- Hmm, maybe coroutine.running() is related?
		print("Does running() give this same coroutine?")
		print("co = ", co)
		print("running gives us: ", coroutine.running())
	end)

	coroutine.resume(co)
end
--]]

--[[
do
	-- Let's round this out and try one coroutine inside another.
	print("Let's nest some coroutines!")

	local outer

	outer = coroutine.create(function()
		print("In the outer coroutine")

		local inner = coroutine.create(function()
			print("And in the inner!")
			print("Status of inner: ", coroutine.status(coroutine.running()))
			print("Status of outer: ", coroutine.status(outer))
		end)

		coroutine.resume(inner)
	end)

	coroutine.resume(outer)
end
--]]