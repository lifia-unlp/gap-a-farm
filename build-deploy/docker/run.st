| adminEmail application dbhost db dbuser dbpassword smtpServer debug |

debug := (OSEnvironment current at: 'DEBUG' ifAbsent: 'false') = 'true'.
dbhost := OSEnvironment current at: 'DB_HOST' ifAbsent: 'mongodb'.
db := OSEnvironment current at: 'DB' ifAbsent: 'gapafarm'.
dbuser := OSEnvironment current at: 'DB_USER' ifAbsent: nil.
dbpassword := OSEnvironment current at: 'DB_PASSWORD' ifAbsent: nil.
smtpServer := OSEnvironment current at: 'SMTP' ifAbsent: nil.
adminEmail := OSEnvironment current at: 'ADMIN_EMAIL' ifAbsent: nil.

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

Transcript cr; show: 'GAP-A-Farm starting  (dbhost: ', dbhost, ', db: ', db, ')'; cr; cr.
