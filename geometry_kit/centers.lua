--- Various triangle centers, in many cases with associated circles.

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
local sqrt = math.sqrt

-- Cached module references --
local _Circumcircle_
local _Orthocenter_

-- Exports --
local M = {}

--- DOCME
function M.Circumcircle ( px, py, qx, qy, rx, ry )
  -- Squared side lengths.
  local A2 = (qx - px)^2 + (qy - py)^2
  local B2 = (rx - qx)^2 + (ry - qy)^2
  local C2 = (px - rx)^2 + (py - ry)^2

  -- Center lines.
  local D, E = px - rx, py - ry
  local F = qx * D + qy * E + (A2 - B2) / 2
  local G, H = qx - rx, qy - ry
  local I = px * G + py * H + (A2 - C2) / 2

  -- Solve for the circumcenter.
  local cx, cy = (E * I - H * F) / (E * G - H * D)

  if E^2 < 1e-12 then -- choose from non-vertical line of centers
    cy = (I - G * cx) / H
  else
    cy = (F - D * cx) / E
  end

  -- Solve for the circumradius.
  return cx, cy, sqrt( (px - cx)^2 + (py - cy)^2 )
end

--
local function DoExcircle ( px, py, qx, qy, rx, ry, circles, contacts, extouch, side )
  -- Deltas for sides A, B, C.
  local ax, ay = qx - px, qy - py
  local bx, by = rx - px, ry - py
  local cx, cy = qx - rx, qy - ry

  -- Squared side lengths.
  local A2 = ax^2 + ay^2
  local B2 = bx^2 + by^2
  local C2 = cx^2 + cy^2

  -- Using the orthocenter approach, find the offset of the foot of q on segment pr, as
  -- well as the height of the associated altitude.
  local bt = .5 * (A2 + B2 - C2) / B2
  local h = sqrt( A2 - B2 * bt^2 )

  -- Side lengths.
  local A = sqrt( A2 )
  local B = sqrt( B2 )
  local C = sqrt( C2 )

  -- Break the pqr triangle into two right triangles at the foot and use this to find angle
  -- information shared by the excircle. This will give us the radius.
  local L, R = bt * B, (1 - bt) * B 
  local TanA, TanB = h / (C + R), h / (A + L)
  local r = B / (TanA + TanB)

  -- From the radius we can find the foot of the center onto the triangle side. Reaching the
  -- center is then simply a matter of walking up the altitude.
  local Bp, dx, dy = r * TanB, bx / B, by / B
  local Fx, Fy = px + Bp * dx, py + Bp * dy

  -- Given the foot and radius, similar triangles will put us at the center.
  circles[side] = { x = Fx - r * dy, y = Fy + r * dx, r = r }

  -- If requested, supply the contact triangle and / or one side of the extouch triangle.
  if contacts or extouch then
    local at, ct = Bp / A, (B - Bp) / C

    if contacts then
      contacts[side] = {
        a = { x = px - at * ax, y = py - at * ay },
        b = { x = Fx, y = Fy },
        c = { x = rx - ct * cx, y = ry - ct * cy }
      }
    end

    if extouch then
      extouch[side] = { x = Fx, y = Fy }
    end
  end
end

--- DOCME
function M.Excircles ( px, py, qx, qy, rx, ry, want_contact_triangles, want_extouch_triangle )
  local contacts, extouch = want_contact_triangles and {}, want_extouch_triangle and {}
  local circles = {}

  DoExcircle( px, py, qx, qy, rx, ry, circles, contacts, extouch, 1 )
  DoExcircle( qx, qy, rx, ry, px, py, circles, contacts, extouch, 2 )
  DoExcircle( rx, ry, px, py, qx, qy, circles, contacts, extouch, 3 )

  return circles, contacts, extouch
end

--- DOCME
function M.Incircle ( px, py, qx, qy, rx, ry, want_contact_triangle )
  -- Side lengths.
  local A = sqrt( (qx - px)^2 + (qy - py)^2 )
  local B = sqrt( (rx - qx)^2 + (ry - qy)^2 )
  local C = sqrt( (px - rx)^2 + (py - ry)^2 )

  -- Partial side lengths.
  local Ap = (A + B - C) / 2
  local Bp = (B + C - A) / 2

  -- Find a couple contact points.
  local a1, b1 = Ap / A, Bp / B
  local a2, b2 = 1 - a1, 1 - b1
  local x1, y1 = a1 * px + a2 * qx, a1 * py + a2 * qy
  local x2, y2 = b1 * qx + b2 * rx, b1 * qy + b2 * ry

  -- Get the midpoint between them. The midpoint is along the way from the corner shared
  -- by the two sides, i.e. q, to the center. Evaluate this partial route.
  local mx, my = (x1 + x2) / 2, (y1 + y2) / 2
  local hx, hy = mx - x1, my - y1
  local vx, vy = mx - qx, my - qy

  -- Together, one of the contact points, the midpoint, and q describe a right triangle.
  -- Get its leg lengths, the "horizontal" and "vertical" distances.
  local H2, V2 = hx^2 + hy^2, vx^2 + vy^2

  -- Find the radius.
  local scale = Ap^2 / V2 -- q-to-center : q-to-midpoint = r * sec(beta) / V = (A' / V)^2
  local r = sqrt(H2 * scale) -- r = A' * tan(alpha)

  -- Scale the direction found earlier. Walk along it from q to reach the center.
  local cx, cy = qx + scale * vx, qy + scale * vy

  -- If requested, find the third, otherwise-redundant contact point and supply the triangle.
  if want_contact_triangle then
    local Cp = (A + C - B) / 2
    local c1 = Cp / C
    local c2 = 1 - c1
    local x3, y3 = c1 * rx + c2 * px, c1 * ry + c2 * py

    return cx, cy, r, {
      a = { x = x1, y = x2 }, b = { x = x2, y = y2 }, c = { x = x3, y = y3 }
    }
  end

  return cx, cy, r
end

--- DOCME
function M.NinePointCircle_Midpoints ( px, py, qx, qy, rx, ry )
  -- Find the circumcircle from three of the points, namely the midpoints.
  local x1, y1 = (px + qx) / 2, (py + qy) / 2
  local x2, y2 = (qx + rx) / 2, (qy + ry) / 2
  local x3, y3 = (rx + px) / 2, (ry + py) / 2

  return _Circumcircle_( x1, y1, x2, y2, x3, y3 )
end

--- DOCME
function M.NinePointCircle_OrthocenterMidpoints ( px, py, qx, qy, rx, ry )
  -- Find the circumcircle from three of the points, namely the orthocenter-to-
  -- triangle corner midpoints.
  local ox, oy = _Orthocenter_( px, py, qx, qy, rx, ry ) 
  local x1, y1 = (px + ox) / 2, (py + oy) / 2
  local x2, y2 = (qx + ox) / 2, (qy + oy) / 2
  local x3, y3 = (rx + ox) / 2, (ry + oy) / 2

  return _Circumcircle_( x1, y1, x2, y2, x3, y3 )
end

--- DOCME
function M.NinePointCircle_OrthicTriangle ( px, py, qx, qy, rx, ry )
  -- Find the circumcircle from three of the points, namely the orthic triangle.
  local _, _, orthic = _Orthocenter_( px, py, qx, qy, rx, ry, true )
  local a, b, c = orthic.a, orthic.b, orthic.c

  return _Circumcircle_( a.x, a.y, b.x, b.y, c.x, c.y )
end

--- DOCME
function M.Orthocenter ( px, py, qx, qy, rx, ry, want_orthic_triangle )
  -- Deltas for sides A, B, C.
  local ax, ay = qx - px, qy - py
  local bx, by = rx - px, ry - py
  local cx, cy = qx - rx, qy - ry

  -- Squared side lengths.
  local A2 = ax^2 + ay^2
  local B2 = bx^2 + by^2
  local C2 = cx^2 + cy^2

  -- Find the foot of the altitude on side B. From there, walk up the altitude (we will be
  -- moving toward point q) until we reach the orthocenter.
  -- sin(beta) = (A2 + B2 - C2) / (2 * A * B)
  local bt = .5 * (A2 + B2 - C2) / B2 -- (A * sin(beta)) / B
  local fx, fy = px + bt * bx, py + bt * by
  local ABSinB, ASinB_2 = B2 * bt, B2 * bt^2 -- A * B * sin(beta); (A * sin(beta))^2
  local h2 = A2 - ASinB_2 -- height = A * cos(beta), which equals C * cos(alpha)
  local ht = (ABSinB - ASinB_2) / h2 -- (A * sin(beta) * tan(alpha)) / (A * cos(beta))
  local ox, oy = fx + ht * (qx - fx), fy + ht * (qy - fy)

  -- If requested, get the orthic triangle's corners too.
  if want_orthic_triangle then
    local at = ABSinB / A2 -- (B * sin(beta)) / A
    local ct = (B2 - ABSinB) / C2 -- (B * sin(alpha)) / C

    return ox, oy, {
      a = { x = px + at * ax, y = py + at * ay },
      b = { x = fx, y = fy },
      c = { x = rx + ct * cx, y = ry + ct * cy }
    }
  end

  return ox, oy
end

-- Cache module members.
_Circumcircle_ = M.Circumcircle
_Orthocenter_ = M.Orthocenter

-- Export the module.
return M