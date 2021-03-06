"
I am a match for a composite parameter specification, and thus cover a (possibly empty) range of words in the arguments sequence.

I provide methods for querying and accessing the matches of my specification's children parameters.
"
Class {
	#name : #ClapCompositeMatch,
	#superclass : #ClapExplicit,
	#instVars : [
		'children'
	],
	#category : #'Clap-Core-Activation'
}

{ #category : #matching }
ClapCompositeMatch >> addChild: aSubExpression [
	children add: aSubExpression
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> at: identifierOrSpec [
	^ self at: identifierOrSpec
		ifAbsent: [
			specification at: identifierOrSpec
				ifPresent: [ :spec | ClapImplicit of: spec in: self ]
				ifAbsent: [ self notYetImplemented ] ]
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> at: identifierOrSpec ifAbsent: absentBlock [
	^ children
		detect: [ :child | identifierOrSpec identifiesClapParameter: child specification ]
		ifNone: absentBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> at: aSpec ifFound: foundBlock [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver at: `@spec ifFound: `@foundBlock'
			-> '`@receiver at: `@spec ifPresent: `@block'.
	^ self at: aSpec ifPresent: foundBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> at: aSpec ifFound: foundBlock ifAbsent: absentBlock [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver at: `@spec ifFound: `@foundBlock ifAbsent: `@absentBlock'
			-> '`@receiver at: `@spec ifPresent: `@block ifAbsent: `@absentBlock'.
	^ self at: aSpec ifPresent: foundBlock ifAbsent: absentBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> at: identifierOrSpec ifPresent: foundBlock [
	^ children
		detect: [ :child | identifierOrSpec identifiesClapParameter: child specification ]
		ifFound: foundBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> at: identifierOrSpec ifPresent: foundBlock ifAbsent: absentBlock [
	^ children
		detect: [ :child | identifierOrSpec identifiesClapParameter: child specification ]
		ifFound: foundBlock
		ifNone: absentBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> atName: aName [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver atName: `@name'
			-> '`@receiver at: `@name'.
	^ self at: aName
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> atName: aName ifFound: aBlock [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver atName: `@name ifFound: `@block'
			-> '`@receiver at: `@name ifPresent: `@block'.
	^ self at: aName ifPresent: aBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> atName: aName ifFound: foundBlock ifAbsent: absentBlock [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver atName: `@name ifFound: `@foundBlock ifAbsent: `@absentBlock'
			-> '`@receiver at: `@name ifPresent: `@block ifAbsent: `@absentBlock'.
	^ self at: aName ifPresent: foundBlock ifAbsent: absentBlock
]

{ #category : #matching }
ClapCompositeMatch >> completeMatchOn: aStream [
	startIndex := aStream position + 1.
	self matchChildrenOn: aStream
]

{ #category : #matching }
ClapCompositeMatch >> detectMatchOn: aStream ifFound: foundBlock ifNone: noneBlock [
	self specification
		parametersSelect: [ :each | each isMatchableIn: self ]
		thenDo: [ :param | 
			| sub |
			sub := param matchOn: aStream in: self context.
			sub isMismatch
				ifFalse: [ ^ foundBlock cull: sub ] ].
	^ noneBlock value
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> flags [
	^ children select: [ :each | specification flags includes: each specification ]
]

{ #category : #testing }
ClapCompositeMatch >> includesMatchNamed: aName [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver includesMatchNamed: `@name'
			-> '`@receiver includesMatchOf: `@name'.
	 ^ self includesMatchOf: aName
]

{ #category : #testing }
ClapCompositeMatch >> includesMatchOf: identifierOrSpec [
	^ children anySatisfy: [ :arg | arg isMatchOf: identifierOrSpec ]
]

{ #category : #initialization }
ClapCompositeMatch >> initialize [
	children := OrderedCollection new
]

{ #category : #matching }
ClapCompositeMatch >> matchChildrenOn: aStream [
	[ self
		detectMatchOn: aStream
		ifFound: [ :arg | arg recordIn: self ]
		ifNone: [ ^ self ]
	] repeat
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> matchedSubcommand: foundBlock ifNone: noneBlock [
	^ children
		detect: [ :child | specification subcommands includes: child specification ]
		ifFound: [ :cmdMatch | foundBlock cull: cmdMatch ]
		ifNone: noneBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> occurrencesNamed: aName [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver occurrencesNamed: `@name'
			-> '`@receiver occurrencesOf: `@name'.
	^ self occurrencesOf: aName
]

{ #category : #enumerating }
ClapCompositeMatch >> occurrencesNamed: aName collect: aBlock [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver occurrencesNamed: `@name collect: `@block'
			-> '`@receiver occurrencesOf: `@name collect: `@block'.
	^ self occurrencesOf: aName collect: aBlock
]

{ #category : #enumerating }
ClapCompositeMatch >> occurrencesNamed: aName do: aBlock [
	self
		deprecated: 'Querying by name or specification has been unified.'
		transformWith: '`@receiver occurrencesNamed: `@name do: `@block'
			-> '`@receiver occurrencesOf: `@name do: `@block'.
	^ self occurrencesOf: aName do: aBlock
]

{ #category : #'accessing - children' }
ClapCompositeMatch >> occurrencesOf: identifierOrSpec [
	^ children select: [ :child | identifierOrSpec identifiesClapParameter: child specification ]
]

{ #category : #enumerating }
ClapCompositeMatch >> occurrencesOf: identifierOrSpec collect: aBlock [
	^ children
		select: [ :child | identifierOrSpec identifiesClapParameter: child specification ]
		thenCollect: aBlock
]

{ #category : #enumerating }
ClapCompositeMatch >> occurrencesOf: identifierOrSpec do: aBlock [
	^ children
		select: [ :child | identifierOrSpec identifiesClapParameter: child specification ]
		thenDo: aBlock
]

{ #category : #evaluating }
ClapCompositeMatch >> positionalValues [
	^ specification positionals
		collect: [ :each | (self at: each) value ]
]

{ #category : #accessing }
ClapCompositeMatch >> stop [
	^ children
		ifEmpty: [ self start ]
		ifNotEmpty: [ children last stop ]
	
]

{ #category : #validation }
ClapCompositeMatch >> validateOn: aReport [
	super validateOn: aReport.
	children do: [ :each | each validateOn: aReport ]
]
