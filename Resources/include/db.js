Ti.include('../include/underscore.js', '../include/active_db.js', '../include/models.js');


Titanium.API.info("Initializing DB");
var db = Titanium.Database.open("ti_store");

(function(db) {
    function initialize_db(db) {
        Titanium.API.log("debug", "initialize_db");

        db.execute('CREATE TABLE IF NOT EXISTS schema_migrations (version STRING NOT NULL PRIMARY KEY)');
    }

    function seed_db(db) {
        Titanium.API.log("debug", "seed_db");
        // use this hook to initialize the database
    }

    function loadMigrations(db)
    {
        var results = {};

        //Get TODOs from database
        var resultSet = db.execute("SELECT * FROM schema_migrations");
        while (resultSet.isValidRow()) {
            var row;
            for (var i = 0; i < resultSet.fieldCount(); i++) {
                row = resultSet.field(i);
            }
            results[row] = row;
            resultSet.next();
        }
        resultSet.close();

        return results;
    }

    function migrate_db(db) {
        var migrations = loadMigrations(db);

        var migration_dir = Titanium.Filesystem.getFile("db/migrations");
        Ti.API.info(migration_dir);
        var files = migration_dir.getDirectoryListing();
        for (var i = 0; i < files.length; i++) {
            var file = files[i];

            var version = file.split(".")[0];

            if (!migrations[version])
            {
                Ti.API.info("Running migration... " + version);
                Ti.include("../db/migrations/"  + file);
            }
        }
    }

    initialize_db(db);
    seed_db(db);
    migrate_db(db);
})(db);

function migrate(version, sql)
{
    db.execute(sql);
    db.execute("INSERT INTO schema_migrations VALUES (?)", version);
}

video_api = new Video(db);