--- Extremely basic coroutine cases.

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

-- Let's make one!
local co = coroutine.create(function()
	print("Inside a coroutine!")
end)

-- Nothing interesting yet:
print("Status, first check: ", coroutine.status(co))

--[[
-- Let's run it once.
print("Running...")

coroutine.resume(co)

print("Status after resume: ", coroutine.status(co))
--]]

--[[
-- Hmm, it's dead... can we run it again?
print("Trying to resume again...")

coroutine.resume(co)

print("Status after trying to resume again: ", coroutine.status(co)) -- Still dead!
--]]

--[[
-- Does resume tell us anything?
print("Attempt to resume gives us: ", coroutine.resume(co))
--]]