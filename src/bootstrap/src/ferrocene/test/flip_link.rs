// SPDX-License-Identifier: MIT OR Apache-2.0
// SPDX-FileCopyrightText: The Ferrocene Developers

use crate::builder::{Builder, RunConfig, ShouldRun, Step};
use crate::core::build_steps::compile;
use crate::core::build_steps::tool::{self, SourceType};
use crate::core::config::TargetSelection;
use crate::Mode;

#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub(crate) struct FlipLink {
    target: TargetSelection,
}

const PATH: &str = "ferrocene/tools/flip-link";

impl Step for FlipLink {
    type Output = ();
    const DEFAULT: bool = true;
    const ONLY_HOSTS: bool = true;

    fn should_run(run: ShouldRun<'_>) -> ShouldRun<'_> {
        run.path(PATH)
    }

    fn make_run(run: RunConfig<'_>) {
        run.builder.ensure(FlipLink { target: run.target });
    }

    fn run(self, builder: &Builder<'_>) -> Self::Output {
        // enable cross-compilation to thumbv7em-none-eabi
        let compiler = builder.compiler(dbg!(builder.top_stage), self.target);
        let cc_target = TargetSelection::from_user("thumbv7em-none-eabi");
        builder.ensure(compile::Std::new(compiler, cc_target));

        builder.info(&format!("Testing {PATH}"));
        builder.run(
            &mut tool::prepare_tool_cargo(
                builder,
                compiler,
                Mode::ToolRustc,
                self.target,
                "test",
                PATH,
                SourceType::Submodule,
                &[],
            )
            .into(),
        );
    }
}
