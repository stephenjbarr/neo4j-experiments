
// ----------------------------------------
// -- get answer type

match (q)-[:HAS_ANS_TYPE]-(a)
where
q.q_name = "Patient_Health_Questionnaire_2_Feeling_Depressed"
return q,a;

// ----------------------------------------
// -- get answer type, typed query

match (q:Question)-[:HAS_ANS_TYPE]-(a:AnsType)
where
q.q_name = "Patient_Health_Questionnaire_2_Feeling_Depressed"
return q,a;

// ----------------------------------------
// -- from question name get answer type and first answer value

match (q:Question)-[:HAS_ANS_TYPE]-(a:AnsType)-[:NEXT_ANS_VAL]-(a1:AnsOption)
where
q.q_name = "Patient_Health_Questionnaire_2_Feeling_Depressed"
return q,a, a1;


// ----------------------------------------
// --

match (q:Question)-[:HAS_ANS_TYPE]-(a:AnsType)-[:NEXT_ANS_VAL*1..]-(a1:AnsOption)
where
q.q_name = "Patient_Health_Questionnaire_2_Feeling_Depressed"
return q,a, a1;

// ----------------------------------------
// --

match (q:Question)-[:HAS_ANS_TYPE]-(a:AnsType)-[:NEXT_ANS_VAL*1..]-(aopt:AnsOption)
where
q.q_name = "Patient_Health_Questionnaire_2_Feeling_Depressed"
return aopt;

// ----------------------------------------
// --

// merge (user),

match (aopt:AnsOption)
where aopt.choice_name = "rating_1_to_10_a2"
return aopt;

match (aopt:AnsOption)-[:NEXT_ANS_VAL]-()
where aopt.choice_name = "rating_1_to_10_a2"
return aopt;


//

match (aopt:AnsOption)-[enav:NEXT_ANS_VAL*1..10]-(at:AnsType)
where aopt.choice_name = "rating_1_to_10_a2"
return aopt, enav, at;


// GET ALL QUESTIONS WITH A GIVEN ANSWER TYPE
match (aopt:AnsOption)-[enav:NEXT_ANS_VAL*1..20]-(at:AnsType)<-[:HAS_ANS_TYPE]-(q)
where aopt.choice_name = "how_often_1_a1"
return aopt, enav, at, q;


// ----------------------------------------
// INPUT: patient_id, answer_value, question_name
// this should really have a UUID
// patient_id = abc123
// q_name:General_Health_Assessment_Smoking
// 

merge (u:User { patient_id = "abc123"})       
match (q:Question)
match (av:AnsOption)
where q.qname        = "General_Health_Assessment_Smoking",
      av.choice_name = "how_often_1_a1"
create (ae:AnsEntity)
create (u)-[ha:HAS_ANSWERED]->(ae)
create (ae)
