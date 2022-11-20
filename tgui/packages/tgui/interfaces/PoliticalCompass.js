import { useBackend } from "../backend";
import { Stack, Section, Box, NoticeBox, Flex, Button } from '../components';
import { Window } from "../layouts";

export const PoliticalCompass = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    questions = [],
    final_result,
    final_color,
    flagicon64,
  } = data;

  return (
    <Window
      title={`Political Compass`}
      width={500}
      height={600}>
      <Window.Content>
        <Stack
          fill
          vertical>
          <Stack.Item
            grow>
            <Section
              fill
              scrollable
              textAlign="center"
              title={`Questions`}>
              {questions.length !== 0 ? (
                <Flex.Item>
                  {questions.map(question => (
                    <Flex.Item
                      key={question.question}>
                      <Section
                        my={2}>
                        {question.question}
                      </Section>
                      {question.answers.map(answer => (
                        <Button
                          mx={0.5}
                          color={answer.selected ? "good" : null}
                          key={answer.answer}
                          onClick={() => act('answerquestion', {
                            question_id: question.qid,
                            answer_id: answer.aid,
                          })}>
                          {answer.answer}
                        </Button>
                      ))}
                      <Button
                        mx={0.5}
                        color={question.unanswered ? "bad" : null}
                        onClick={() => act('removeanswer', {
                          question_id: question.qid,
                        })}>
                        I am not sure
                      </Button>
                    </Flex.Item>
                  ))}
                </Flex.Item>
              ) : (
                <NoticeBox>No questions available!</NoticeBox>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Box my={1} />
          </Stack.Item>
          <Stack.Item>
            <Section
              textAlign="center"
              title={`Results`}>
              <Box
                fontSize={1.5}>
                You are:
                <Box color={final_color}>
                  {final_result}
                  {(flagicon64 ? true : false) && (
                    <Box
                      mx={0.5}
                      as="img"
                      src={`data:image/jpeg;base64,${flagicon64}`}
                      style={{
                        '-ms-interpolation-mode': 'nearest-neighbor',
                      }} />
                  )}
                </Box>
                <Button
                  color={"bad"}
                  onClick={() => act('reset')}>
                  Reset
                </Button>
              </Box>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
