import { useBackend } from "../backend";
import { Box, Button, Section, Table } from '../components';
import { Window } from "../layouts";

export const WhoMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    clients = [],
    total_clients,
  } = data;

  return (
    <Window
      title="Who"
      width={800}
      height={600}
      theme="quake">
      <Window.Content scrollable>
        <Section title="Players">
          <Table>
            <Table.Row
              className="Table__row"
              style={{
                'background-color': 'rgba(0, 0, 128, 0.25)',
              }}
              verticalAlign="middle"
              header>
              <Table.Cell collapsing textAlign="left">
                Key
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                Status
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                Job
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                Ping
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                Country
              </Table.Cell>
            </Table.Row>
            {clients.map(client => (
              <Table.Row
                className="Table__row candystripe"
                key={client.key}>
                <Table.Cell collapsing textAlign="left">
                  {client.key}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  {client.status}
                  {client.mob_ref && (
                    <Button
                      circular
                      ml={1}
                      icon="question"
                      onClick={() => act("admin_more_info", {
                        mob_ref: client.mob_ref,
                      })}
                    />
                  )}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  {client.job}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  {client.ping}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center">
                  {client.country}
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
          <Box
            mt={1}
            textAlign="center">
            <Box inline mx={1}>
              <b>Total Players:</b>
            </Box>
            <Box inline>
              {total_clients}
            </Box>
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
