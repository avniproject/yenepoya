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
        dev: []
      },
      forms: [],
      formMappings: [],
      formDeletions: [],
      formAdditions: [],
      catchments: [],
      checklistDetails: [],
      concepts: [],
      addressLevelTypes: [],
      locations: [],
      programs: [],
      encounterTypes: [],
      operationalEncounterTypes: [],
      operationalPrograms: [],
      subjectTypes: [],
      operationalSubjectTypes: [],
      users: {
        dev: []
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
