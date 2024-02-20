import { useBackend } from "../backend";
import { Box, Section, Table } from '../components';
import { Window } from "../layouts";

export const AdminWhoMenu = (props, context) => {
  const { data } = useBackend(context);
  const {
    admins = [],
    total_admins,
  } = data;

  return (
    <Window
      title="Admin Who"
      width={400}
      height={600}>
      <Window.Content scrollable>
        <Section
          title="Admins">
          <Table>
            <Table.Row
              className="Table__row"
              style={{
                'background-color': 'rgba(90, 85, 110, 0.5)',
              }}
              verticalAlign="middle"
              header>
              <Table.Cell textAlign="left">
                Key
              </Table.Cell>
              <Table.Cell textAlign="left">
                Rank
              </Table.Cell>
            </Table.Row>
            {admins.map(admin => (
              <Table.Row
                className="Table__row candystripe"
                key={admin.key}>
                <Table.Cell textAlign="left">
                  {admin.key}
                </Table.Cell>
                <Table.Cell textAlign="left">
                  {admin.rank}
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
          <Box mt={1} textAlign="center">
            <Box inline mx={1}>
              <b>Total Admins:</b>
            </Box>
            <Box inline>
              {total_admins}
            </Box>
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
