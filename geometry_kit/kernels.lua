--- Various shape kernels.

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
do
	local kernel = { category = "filter", group = "geometry_kit", name = "dashes" }

	kernel.vertexData = {
		{ name = "spacing", min = 1, max = 100, default = 7, index = 0 },
		{ name = "x", index = 1 },
		{ name = "y", index = 2 }
	}

	kernel.vertex = [[
		varying P_POSITION vec2 v_Pos;

		P_POSITION vec2 VertexKernel (P_POSITION vec2 pos)
		{
			v_Pos = pos;

			return pos;
		}
	]]

	kernel.fragment = [[
		varying P_POSITION vec2 v_Pos;

		P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
		{
			P_UV float offset = mod(length(v_Pos - CoronaVertexUserData.yz) / CoronaVertexUserData.x, 2.);

			return CoronaColorScale(texture2D(CoronaSampler0, uv)) * step(offset, 1.);
		}
	]]

	graphics.defineEffect(kernel)
end

do
	local kernel = { category = "filter", group = "geometry_kit", name = "arc_dashes" }

	kernel.vertexData = {
		{ name = "angles", min = 0, max = 0xFFFF, default = 0xFF00, index = 0 },
		{ name = "cx", default = 0, index = 1 },
		{ name = "cy", default = 0, index = 2 },
		{ name = "spacing", min = math.pi / 50, max = 4 * math.pi, default = 4 * math.pi, index = 3 }
	}

	kernel.vertex = [[
		varying P_UV float a1, a2;
		varying P_POSITION vec2 offset;

		P_POSITION vec2 VertexKernel (P_POSITION vec2 pos)
		{
			a1 = mod(CoronaVertexUserData.x, 256.) / 255.;
			a2 = (CoronaVertexUserData.x - a1) / (256. * 255.);
			offset = pos - CoronaVertexUserData.yz;

			return pos;
		}
	]]

	kernel.fragment = [[
		P_UV float PI = 4. * atan(1.);
		P_UV float TWO_PI = 2. * PI;

		varying P_UV float a1, a2;
		varying P_POSITION vec2 offset;

		P_COLOR vec4 FragmentKernel (P_UV vec2 uv)
		{
			P_UV float angle = mod(atan(offset.y, offset.x), TWO_PI);

			// Outside the arc? (Also, detect the 0 -> 2 * pi branch.)
			if (a1 < a2)
			{
				if (angle < a1 * TWO_PI || angle > a2 * TWO_PI) return vec4(0.);
			}
		   
			else
			{
				if (angle < a1 * TWO_PI && angle > a2 * TWO_PI) return vec4(0.);
			}

			P_UV float offset = mod(angle / CoronaVertexUserData.w, 2.);

			return CoronaColorScale(texture2D(CoronaSampler0, uv)) * step(offset, 1.);
		}
	]]

	graphics.defineEffect(kernel)
end