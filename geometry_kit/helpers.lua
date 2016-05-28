--- Common helpers.

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

-- Corona globals --
local display = display
local native = native

-- Cached module references --
local _Line_
local _Text_
local _Tick_

-- Kernels --
require("kernels")

-- Exports --
local M = {}

--- DOCME
function M.HLine (x1, x2, y, dashed)
	return _Line_(x1, y, x2, y, dashed)
end

--- DOCME
function M.Line (x1, y1, x2, y2, dashed)
	local line = display.newLine(x1, y1, x2, y2)

	line:setStrokeColor(0)

	if dashed then
		local stroke = line.stroke

		stroke.effect = "filter.geometry_kit.dashes"
		stroke.effect.x = x1
		stroke.effect.y = y1
	end

	line.strokeWidth = dashed and 2 or 3

	return line
end

--- DOCME
function M.Text (str, x, y, size)
	local text = display.newText(str, x, y, native.systemFontBold, size or 22)

	text:setTextColor(0)

	return text
end

--
local function DoOpts (opts)
	local line_style, margin, size

	if opts then
		line_style, margin, size = opts.line_style, opts.margin, opts.size
	end

	return line_style, size or 18, margin or 2
end

--
local function IsDashed (style)
	return style == "dashed" or style == "dashed_multi"
end

--
local function Single (style)
	return style ~= "multi" and style ~= "dashed_multi"
end

--- DOCME
function M.TextBelow (str, x1, x2, y, ty, opts)
	local line_style, size = DoOpts(opts)
	local tick1, tick2 = _Tick_(x1, y), _Tick_(x2, y)
	local line = _Line_(x1, y, x2, y, IsDashed(line_style))
	local text = _Text_(str, (x1 + x2) / 2, y + ty, size)

	return text, tick1, tick2, line
end

--- DOCME
function M.TextBelow_Multi (str_to_x2, x1, y, ty, opts)
	local line_style, size = DoOpts(opts)
	local texts, ticks, lines = {}, { _Tick_(x1, y) }, {}
	local x0, is_dashed = Single(line_style) and x1, IsDashed(line_style)

	for i = 1, #str_to_x2, 2 do
		local str, x2 = str_to_x2[i], str_to_x2[i + 1]

		texts[#texts + 1] = _Text_(str, (x1 + x2) / 2, y + ty, size)
		ticks[#ticks + 1] = _Tick_(x2, y)

		if not x0 then
			lines[#lines + 1] = _Line_(x1, y, x2, y, is_dashed)
		end

		x1 = x2
	end

	if x0 then
		lines[#lines + 1] = _Line_(x0, y, x1, y, is_dashed)
	end

	return texts, ticks, lines
end

--- DOCME
function M.TextBetween (str, x1, x2, y, opts)
	local line_style, size, margin = DoOpts(opts)
	local tick1, tick2 = _Tick_(x1, y), _Tick_(x2, y)
	local text = _Text_(str, (x1 + x2) / 2, y, size)
	local half, is_dashed = text.contentWidth / 2, IsDashed(line_style)
	local line1 = _Line_(x1, y, text.x - half - margin, y, is_dashed)
	local line2 = _Line_(text.x + half + margin, y, x2, y, is_dashed)

	return text, tick1, tick2, line1, line2
end

--- DOCME
function M.TextBetween_Multi (str_to_x2, x1, y, opts)
	local line_style, size, margin = DoOpts(opts)
	local texts, ticks, lines = {}, { _Tick_(x1, y) }, {}
	local is_dashed = IsDashed(line_style)

	for i = 1, #str_to_x2, 2 do
		local str, x2 = str_to_x2[i], str_to_x2[i + 1]

		ticks[#ticks + 1] = _Tick_(x2, y)

		local text = _Text_(str, (x1 + x2) / 2, y, size)
		local half = text.contentWidth / 2

		texts[#texts + 1] = text
		lines[#lines + 1] = _Line_(x1, y, text.x - half - margin, y, is_dashed)
		lines[#lines + 1] = _Line_(text.x + half + margin, y, x2, y, is_dashed)

		x1 = x2
	end

	return texts, ticks, lines
end

--- DOCME
function M.Tick (x, y)
	return _Line_(x, y - 10, x, y + 10)
end

--- DOCME
function M.VLine (x, y1, y2, dashed)
	return _Line_(x, y1, x, y2, dashed)
end

-- Cache module references.
_Line_ = M.Line
_Text_ = M.Text
_Tick_ = M.Tick

-- Export the module.
return M