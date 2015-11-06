module.exports = grammar
	name: "swift"

	rules:
		program: -> repeat(@_statement)


		# Statements

		_statement: -> seq(choice(
			@_expression,
			@_declaration,
			@_loop_statement,
			# @_branch_statement,
			# @_labeled_statement,
			# @_control_transfer_statement,
			# @defer_statement,
			# @do_statement
		), ';')

		_statements: -> repeat(@_statement)

		_loop_statement: -> choice(
			@for_statement,
			# @for_in_statement,
			# @while_statement,
			# @repeat_while_statement
		)

		for_statement: -> seq(
			'for',
			choice(
				@_for_condition,
				seq('(', @_for_condition, ')')
			),
			@_code_block
		)

		_for_init: -> choice(
			@variable_declaration,
			@_expression_list
		)

		_for_condition: -> seq(
			optional(@_for_init),
			';',
			optional(@_expression),
			';',
			optional(@_expression)
		)

		_code_block: -> seq(
			'{',
			@_statements,
			'}'
		)


		# Declarations

		_declaration: ->
			'import'


		# Expressions

		_expression: ->
			'try'

		_expression_list: -> commaSep1(@_expression)


		# Lexical Structure

		identifier: -> token(choice(
			seq(
				@_identifier_head,
				optional(@_identifier_characters)
			),
			seq(
				'`',
				@_identifier_head,
				optional(@_identifier_characters),
				'`'
			)
		))

		_identifier_head: ->
			/[A-Za-z_]/

		_identifier_characters: -> repeat(choice(
			@_identifier_head,
			/[0-9]/
		))


	ubiquitous: -> [
		/\s+/
	]
