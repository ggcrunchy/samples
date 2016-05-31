--- Color utilities for shape drawing.

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

-- Standard library imports --
local abs = math.abs
local max = math.max
local select = select
local type = type
local unpack = unpack

-- Cached module references --
local _ApplyColor_
local _SetColor_

-- Exports --
local M = {}

--
local function GetRGBA (v, key)
	local color, r, g, b, a = v[key]

	if type(color) == "table" then
		r, g, b, a = unpack(color)

		if #color == 2 then
			a, g, b = g, r, r
		end
	else
		r = color or 0
		g, b = r, r
	end

	return r, g, b, a or 1
end

--- DOCME
function M.ApplyColor (object, ckey, v1, v2, dashed)
	if object then -- TODO: appropriate?
		local r1, g1, b1, a1 = GetRGBA(v1, ckey)
		local r2, g2, b2, a2 = GetRGBA(v2, ckey)

		if max(abs(r2 - r1), abs(g2 - g1), abs(b2 - b1), abs(a2 - a1)) > 1e-2 then
			object:setStrokeColor(1, 1)

			object.stroke = {
				type = "gradient", direction = "right",
				color1 = { r1, g1, b1, a1 },
				color2 = { r2, g2, b2, a2 }
			}
		else
			object:setStrokeColor(r1, g1, b1, a1)
		end
	end
end

--- DOCME
function M.SetColor (into, ckey, ...)
	local n = select("#", ...)

	if n == 0 or type(...) == "table" then
		into[ckey] = nil
	elseif n == 1 then
		into[ckey] = ...
	else
		into[ckey] = { ... }
	end
end

--- DOCME
function M.SetThenApply (T, index, okey, ckey, ...)
	local v = T[index]

	_SetColor_(v, ckey, ...)
	_ApplyColor_(v[okey], ckey, v)
end

--- DOCME
function M.SetThenApplyToArray (T, index, akey, ckey, n, ...)
	local v = T[index]
	local varr = v[akey]

	--
	_SetColor_(v, ckey, ...)

	for i = 1, #(varr or "") do
		_ApplyColor_(varr[i], ckey, v)
	end
end

-- Cache module members.
_ApplyColor_ = M.ApplyColor
_SetColor_ = M.SetColor

-- Export the module.
return M