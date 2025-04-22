{
	source: {
		name: "hadolint",
		url: "https://github.com/hadolint/hadolint"
	},
	diagnostics: . | map({
		message: .message,
		code: {
			value: .code,
			url: (
				if .code | startswith("DL") then
					"https://github.com/hadolint/hadolint/wiki/\(.code)"
				elif .code | startswith("SC") then
					"https://github.com/koalaman/shellcheck/wiki/\(.code)"
				else
					null
				end
			),
		},
		location: {
			path: .file,
			range: {
				start: {
					line: .line,
					column: .column
				}
			}
		},
		severity: ((.level|ascii_upcase|select(match("ERROR|WARNING|INFO")))//null)
	})
}
