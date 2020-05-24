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
            forms: [
                "forms/Household Registration.json",
                "forms/Individual Registration Form.json",
                "forms/Household Survey.json",
                "forms/Individual Survey.json",
                "forms/Encounter survey cancel.json",
                "forms/Fever Survey cancel form.json",
                "forms/History of Fever.json",
                "forms/Diabetes Enrolment.json",
                "forms/Diabetes Followup.json",
                "forms/Hypertension Enrolment.json",
                "forms/Hypertension Followup.json",
                "forms/NCD Enrolment.json",
                "forms/NCD Followup.json",
                "forms/Program encounter cancellation.json",
                "forms/Program exit form.json"



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
            genders: ["genders.json"],
            operationalEncounterTypes: ["operationalEncounterTypes.json"],
            operationalPrograms: ["operationalPrograms.json"],
            subjectTypes: ["subjectTypes.json"],
            operationalSubjectTypes: ["operationalSubjectTypes.json"],
            users: {
                "dev": ["users/dev-users.json"]
            },
            rules: [
                // "./rules.js"
            ],
            organisationSql: [
                /* "create_organisation.sql"*/
            ],
            "organisationConfig": [],
            "translations": []
        }
    },
    rulesConfigInfra
);
