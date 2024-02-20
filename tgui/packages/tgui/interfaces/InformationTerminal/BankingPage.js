import { useBackend } from "../../backend";
import { TERMINAL_PAGE_INDEX } from './constants';
import { LabeledList, Stack, NumberInput, Box, Button } from "../../components";

export const BankingPage = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    account_holder,
    account_id,
    account_balance,
  } = data;

  return (
    <Stack
      vertical
    >
      <Stack.Item>
        <Box
          style={{
            "font-size": "150%",
          }}
        >
          <LabeledList>
            <LabeledList.Item label="Account Name">
              {account_holder}
            </LabeledList.Item>
            <LabeledList.Item label="Account ID">
              {account_id}
            </LabeledList.Item>
            <LabeledList.Item label="Account Balance">
              {account_balance}
            </LabeledList.Item>
            <LabeledList.Item label="Withdraw">
              <NumberInput
                onChange={(e, value) => act("withdraw", {
                  amount: value,
                })}
                minValue={0}
                maxValue={1000}
                value={10}
              />
            </LabeledList.Item>
          </LabeledList>
        </Box>
      </Stack.Item>
      <Stack.Item mt={2.5}>
        <Button
          style={{
            "font-size": "150%",
          }}
          onClick={() => act("switch_page", {
            new_page: TERMINAL_PAGE_INDEX,
          })}
          ml={1}
        >
          Back
        </Button>
      </Stack.Item>
    </Stack>
  );
};
