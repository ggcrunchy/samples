--- Coroutine wait utilities.

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

-- Exports --
local M = {}

-- All of these have optional updates.

-- Wait some number of milliseconds.
function M.WaitMS (time, update)
	local now = system.getTimer()
	local ends_at = now + time

	while now < ends_at do
		if update then
			update()
		end

		coroutine.yield()

		now = system.getTimer()
	end
end

-- Wait for some property to be true.
function M.WaitUntilPropertyTrue (object, name, update)
	while not object[name] do
		if update then
			update()
		end

		coroutine.yield()
	end
end

-- Wait for some predicate to be true.
function M.WaitUntilTrue (func, update)
	while not func() do
		if update then
			update()
		end

		coroutine.yield()
	end
end

-- Export the module.
return M