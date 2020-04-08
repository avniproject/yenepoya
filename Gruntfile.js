const rulesConfigInfra = require("rules-config/infra");
const IDI = require("openchs-idi");

module.exports = IDI.configure(
    {
        name: "Yenepoya",
        "chs-admin": "admin",
        "org-name": "Yenepoya",
        "org-admin": "admin@yenepoya",
        secrets: "../secrets.json",
        files: {
            adminUsers: {
                "dev": ["users/admin-user.json"]
            },
            forms: ["forms/householdRegistartion.json",
                "forms/individualRegistartion.json",
                "forms/householdSurvey.json",
                "forms/individualSurvey.json"
            ],
            formMappings: ["formMappings.json"],
            formDeletions: [],
            formAdditions: [],
            catchments: [
                "metadata/sample_catchment.json"
            ],
            checklistDetails: [],
            concepts: ["concepts.json"],
            addressLevelTypes: [],
            locations: ["metadata/location.json"],
            programs: ["programs.json"],
            encounterTypes: ["encounterTypes.json"],
            operationalEncounterTypes: ["operationalEncounterTypes.json"],
            operationalPrograms: ["operationalPrograms.json"],
            subjectTypes: ["subjectTypes.json"],
            operationalSubjectTypes: ["operationalSubjectTypes.json"],
            users: {
                "dev": ["users/dev-users.json"]
            },
            rules: [],
            organisationSql: [
                /* "create_organisation.sql"*/
            ],
            "organisationConfig": [],
            "translations": []
        }
    },
    rulesConfigInfra
);
