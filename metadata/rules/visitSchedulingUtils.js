import moment from 'moment';


class surveyIndividual {

    static scheduleOn(Encounter, date) {
        const earliestDate = moment(date).add('1', 'year').toDate();
        const maxDate = moment(earliestDate).add('15', 'days').toDate();

        return {
            name: "Individual Survey",
            encounterType: "Individual Survey",
            earliestDate: earliestDate,
            maxDate: maxDate
        };
    }

    static scheduleOnRegistration(date) {
        const earliestDate = date;
        const maxDate = moment(earliestDate).add('15', 'days').toDate();

        return {
            name: "Individual Survey",
            encounterType: "Individual Survey",
            earliestDate: earliestDate,
            maxDate: maxDate
        };
    }


}

class surveyHousehold {
    static scheduleOn(date) {
        const earliestDate = moment(date).add('1', 'year').toDate();
        const maxDate = moment(earliestDate).add('15', 'days').toDate();

        return {
            name: "Household Survey",
            encounterType: "Household Survey",
            earliestDate: earliestDate,
            maxDate: maxDate
        };

    }

    static scheduleOnRegistration(date) {
        const earliestDate = date;
        const maxDate = moment(earliestDate).add('15', 'days').toDate();

        return {
            name: "Household Survey",
            encounterType: "Household Survey",
            earliestDate: earliestDate,
            maxDate: maxDate
        };
    }
}

class surveyFever {
    static scheduleOn(date) {
        const earliestDate = date;
        const maxDate = moment(earliestDate).add('15', 'days').toDate();
        return {
            name: "History of Fever",
            encounterType: "History of Fever",
            earliestDate: earliestDate,
            maxDate: maxDate
        };
    }
}


export {

    surveyIndividual,
    surveyHousehold,
    surveyFever
}