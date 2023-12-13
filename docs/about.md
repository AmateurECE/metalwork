# Why Does This Exist?

What problem am I trying to solve here? I learned C++ development in college,
and started doing it professionally in the embedded space after graduating. Two
years later, I decided to learn Rust in my free time. After becoming proficient
in the Rust ecosystem, coming back to C++ left me significantly disappointed.
Most of us in the embedded space are still writing code like it's 2005. At the
same time, however, there's significant hesitance in the industry to move
towards a modern language that supports efficient workflows.

I spend more time at work fucking with my toolchains than I do writing code.
It's either setting up a shitty toolchain that someone else put together, or
it's trying to set up my own shitty toolchain as fast as possible because
managers and customers are breathing down my neck to start making progress
against the backlog.

We have no excuse. There's a great ecosystem of tools out there to support
development. And while there's some shitty choices we continue to make over and
over again--like using CMake, or even more broadly, _choosing_ C++--there's no
excuse not to be using modern tools to solve problems like dependency
management.

# But What About All the Other Solutions Out There?

Like what? Seriously. There's a lot of utter garbage out there. I'm not trying
to reinvent anything that already exists, I'm just trying to make our shitty
solutions a little fucking easier to use on a project.

## How Does Metalwork Compare to PlatformIO?

PlatformIO is a sledgehammer. It tries to be a build system, an IDE, a package
manager, and a cloud-native platform. That's why almost nobody is using it in
more specialized industries. I'm sure it's absolutely fabulous if you're trying
to hack together some privacy-invasive consumer IoT shit, but those of us that
write control loops, applications for softcores, and shit that controls _real_
things in the _real world_ don't want that kind of solution.

# What is it that I think I'm bringing to the ecosystem?

Maybe nothing. I'm not so arrogant to believe that this isn't going to be
another shitty solution to one of our myriad of problems. But my experiences
with other toolchains in the past has given me the motivation to try something
different, with some specific goals, and hope that whatever I make sucks a
little less than our other options.

Oh, and here are those goals I mentioned:

1. Don't be an ecosystem. Contribute broadly to the existing ecosystem with
   patches, pull requests, documentation, examples and (where appropriate)
   infrastructure.
2. Help engineers to get started, and then get out of the way as fast as
   possible.
3. Use examples (as a first resort) and documentation (as a second resort) to
   fill in the instruction gaps created by existing solutions and coach others
   on how to solve problems using popular, existing technologies.
