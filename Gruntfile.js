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
                "forms/Program exit form.json",
                "forms/ANC Followup.json",
                "forms/ANC Followup Encounter Cancellation (voided~979).json",
                "forms/Batch Registration (voided~237).json",
                "forms/Child Enrolment.json",
                "forms/Child Growth and Health status Followup.json",
                "forms/Diabetes Exit (voided~720).json",
                "forms/ET Enrolment (voided~232).json",
                "forms/ET Exit (voided~233).json",
                "forms/ET Session Followup Encounter (voided~234).json",
                "forms/ET Session Followup Encounter Cancellation (voided~235).json",
                "forms/Household Registration(voided).json",
                "forms/Hypertension Exit (voided~725).json",
                "forms/Mother PNC Encounter Cancellation (voided~1008).json",
                "forms/NCD  Exit (voided~745).json",
                "forms/PNC Followup.json",
                "forms/Pregnancy Enrolment.json",
                "forms/Pregnancy Exit (voided~975).json",
                "forms/Pregnancy Outcome.json",
                "forms/Vaccination Checklist Form.json"
            ],
            formMappings: ["formMappings.json"],
            formDeletions: [],
            formAdditions: [],
            catchments: [
               "metadata/sample_catchment.json"
            ],
           // checklistDetails: ["checklist.json"],
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
