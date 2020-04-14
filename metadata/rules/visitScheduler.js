import {surveyIndividual, surveyHousehold, surveyFever} from "./visitSchedulingUtils";
import {RuleFactory, VisitScheduleBuilder} from "rules-config";
import _ from 'lodash';

const IndividualVisit = RuleFactory('03d87073-88cf-48c7-aa89-c8167b57d938', "VisitSchedule");
const HouseholdVisit = RuleFactory('c1534442-907e-47ac-ac76-45c77ad05330', "VisitSchedule");
const householdRegistrationVisit = RuleFactory('9f3c4fbc-06ed-4434-933d-d985f3153f22', "VisitSchedule");
const individualRegistrationVisit = RuleFactory('004628e4-acc8-4d20-a2c1-a838767a53c6', "VisitSchedule");
const feverHistoryCancel = RuleFactory('95d278aa-7804-43fc-8628-7616510b8508', "VisitSchedule");


@householdRegistrationVisit("5e3c8b3c-e049-44eb-8fd6-54c0ab71d86e", "yenepoya Household Registration", 100.0)
class householdRegVisit {
    static exec(individual) {
        const scheduleBuilder = new VisitScheduleBuilder({individual});
        scheduleBuilder.add(surveyHousehold.scheduleOnRegistration(individual.registrationDate));
        return scheduleBuilder.getAll();
    }
}


@individualRegistrationVisit("71709ad3-8c28-4dfb-afdb-aab9ac352228", "yenepoya Individual Registration", 100.0)
class individualRegVisit {
    static exec(individual) {
        const scheduleBuilder = new VisitScheduleBuilder({individual});
        scheduleBuilder.add(surveyIndividual.scheduleOnRegistration(individual.registrationDate));
        return scheduleBuilder.getAll();
    }
}


@IndividualVisit("c6157e3c-9d75-450e-b3a7-eba4abaa47ab", "yenepoya Individual Survey", 100.0)
class individualsurveyVisit {
    static exec(Encounter) {
        const scheduleBuilder = new VisitScheduleBuilder({Encounter});
        scheduleBuilder.add(surveyIndividual.scheduleOn(Encounter, Encounter.encounterDateTime));
        const feverStatus = Encounter.getObservationReadableValue('History of fever in last 15 days');


        if (feverStatus === 'Yes') {
            scheduleBuilder.add(surveyFever.scheduleOn(Encounter.encounterDateTime));
        }
        return scheduleBuilder.getAll();
    }
}

@HouseholdVisit("2b3c0db9-057e-47cc-82d7-dcada3e74058", "yenepoya Household Survey", 100.0)
class householdSurveyVisit {
    static exec(Encounter) {
        const scheduleBuilder = new VisitScheduleBuilder({Encounter});
        scheduleBuilder.add(surveyHousehold.scheduleOn(Encounter.encounterDateTime));

        return scheduleBuilder.getAll();
    }
}


export {
    individualsurveyVisit,
    householdSurveyVisit,
    individualRegVisit,
    householdRegVisit
}