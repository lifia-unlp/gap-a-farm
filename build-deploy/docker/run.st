| adminEmail application dbhost db dbuser dbpassword smtpServer debug demo |

debug := (OSEnvironment current at: 'DEBUG' ifAbsent: 'false') = 'true'.
Transcript show: 'DEBUG: ', debug printString; cr.
dbhost := OSEnvironment current at: 'DB_HOST' ifAbsent: 'mongodb'.
Transcript show: 'DB_HOST: ', dbhost printString; cr.
db := OSEnvironment current at: 'DB' ifAbsent: 'gapafarm'.
Transcript show: 'DB: ', db printString; cr.
dbuser := OSEnvironment current at: 'DB_USER' ifAbsent: nil.
dbpassword := OSEnvironment current at: 'DB_PASSWORD' ifAbsent: nil.
smtpServer := OSEnvironment current at: 'SMTP' ifAbsent: nil.
Transcript show: 'SMTP: ', smtpServer printString; cr.
adminEmail := OSEnvironment current at: 'ADMIN_EMAIL' ifAbsent: nil.
Transcript show: 'ADMIN_EMAIL: ', adminEmail printString; cr.
demo := (OSEnvironment current at: 'DEMO' ifAbsent: 'false') = 'true'.
Transcript show: 'DEMO: ', demo printString; cr.


"SMTP server for error reporting"
MailComposition setSmtpServer: smtpServer.

dbuser
	ifNil: [ (VOMongoRepository
			host: dbhost
			database: db) enableSingleton ]
	ifNotNil: [ (VOMongoRepository
			host: dbhost
			database: db
			username: dbuser
			password: dbpassword) enableSingleton ].

debug ifFalse: [
	WAAdmin defaultServerManager adaptors
        do: [ :each | WAAdmin defaultServerManager unregister: each ].
	WAAdmin applicationDefaults
		removeParent: WADevelopmentConfiguration instance.
].

ZnZincServerAdaptor startOn: 8080.


application := WAAdmin
	register: GAFLandingComponent
	asApplicationAt: GAFLandingComponent applicationName.

application sessionClass: GAFSession.
application configuration addParent: GAFConfiguration instance.
application preferenceAt: #adminEmail put: adminEmail.

smtpServer notNil
		ifTrue: [ application exceptionHandler: GAFEmailErrorHandler ].

application
	addLibrary: JQDeploymentLibrary;
	addLibrary: JQUiDeploymentLibrary;
	addLibrary: SBSDeploymentLibrary .

WAAdmin defaultDispatcher defaultName: GAFLandingComponent applicationName.

GAFDeployer demoMode: demo.

Transcript cr; show: 'GAP-A-Farm started'; cr; cr.
Transcript show: 'This line will be lost ... eaten by the container?'
