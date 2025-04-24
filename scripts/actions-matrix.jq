{
	include: [
		.tasks[] | select(
			.name | startswith("reviewdog:") and (
				(
					endswith("default") or endswith("matrix")
				) | not
			)
		) | {
			target: .name
		}
	]
}
