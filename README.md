# NPMSemver

[![Hex.pm](https://img.shields.io/hexpm/v/npm_semver.svg)](https://hex.pm/packages/npm_semver)
[![CI](https://github.com/elixir-volt/npm_semver/actions/workflows/ci.yml/badge.svg)](https://github.com/elixir-volt/npm_semver/actions/workflows/ci.yml)

npm-compatible semantic versioning for Elixir.

Parse and match version ranges using npm's semver syntax: `^1.2.3`,
`~1.2.3`, `>=1.0.0 <2.0.0`, `1.x`, `1.0.0 - 2.0.0`, `||` unions.

## Installation

```elixir
def deps do
  [{:npm_semver, "~> 0.1.0"}]
end
```

## Usage

```elixir
NPMSemver.matches?("1.2.3", "^1.0.0")
# => true

NPMSemver.matches?("2.0.0", "^1.0.0")
# => false

NPMSemver.matches?("1.5.0", ">=1.2.3 <2.0.0")
# => true

NPMSemver.matches?("2.1.3", "2.x.x")
# => true
```

### Find best match

```elixir
NPMSemver.max_satisfying(["1.0.0", "1.5.0", "2.0.0"], "^1.0.0")
# => "1.5.0"
```

### hex_solver integration

Convert npm ranges to constraints for [hex_solver](https://hex.pm/packages/hex_solver) (PubGrub dependency resolver):

```elixir
{:ok, constraint} = NPMSemver.to_hex_constraint("^1.2.3")
```

Or get the Elixir requirement string directly:

```elixir
NPMSemver.to_elixir_requirement("^1.2.3")
# => {:ok, ">= 1.2.3 and < 2.0.0-0"}
```

## Supported syntax

| Syntax | Example | Expands to |
|--------|---------|------------|
| Caret | `^1.2.3` | `>=1.2.3 <2.0.0` |
| Tilde | `~1.2.3` | `>=1.2.3 <1.3.0` |
| X-range | `1.2.x`, `1.*`, `*` | `>=1.2.0 <1.3.0` |
| Comparator | `>=1.0.0 <2.0.0` | as written |
| Hyphen | `1.0.0 - 2.0.0` | `>=1.0.0 <=2.0.0` |
| Union | `^1.0 \|\| ^2.0` | either range |
| Intersection | `>=1.2.1 <=1.2.8` | space-separated AND |

## Options

- `loose: true` — accept `v`-prefixed versions and pre-release tags without `-` separator
- `include_prerelease: true` — x-ranges and `*` match pre-release versions

## Testing

216 test cases ported from [node-semver](https://github.com/npm/node-semver) fixtures.

## Part of Elixir Volt

npm_semver brings npm-compatible semantic version ranges to Elixir.

It is part of a frontend stack that runs inside the BEAM — builds, JS
runtimes, icons, and Vue-to-LiveView compilation as supervised parts of the
application instead of external toolchain processes. See the
[Elixir Volt](https://github.com/elixir-volt) organization for the rest, and
[Building Blocks for the Future Web](https://github.com/elixir-vibe/building-blocks)
for the thesis, architecture, and roadmap that tie them together.

## License

MIT
