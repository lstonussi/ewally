import 'package:ewally/app/data/models/statement_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class StatementTitle extends StatefulWidget {
  const StatementTitle(
      {Key key, @required this.statementModel, @required this.showDetails})
      : assert(statementModel != null),
        super(key: key);

  final StatementModel statementModel;
  final Function showDetails;

  @override
  _StatementTitleState createState() => _StatementTitleState();
}

class _StatementTitleState extends State<StatementTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Conta #${widget.statementModel.accountName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        GestureDetector(
          child: Text(
            'Grafico',
            style: TextStyle(
              color: Color(0xffb6b2b2),
            ),
          ),
          onTap: widget.showDetails,
        ),
      ],
    );
  }
}

class InnerTimeline extends StatelessWidget {
  const InnerTimeline({
    @required this.statementModel,
  });

  final StatementModel statementModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          FixedTimeline(
            theme: TimelineTheme.of(context).copyWith(
              nodePosition: 0,
              connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                    thickness: 1.0,
                  ),
              indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                    size: 10.0,
                    position: 0.5,
                  ),
            ),
          ),
          TimelineTile(
            node: TimelineNode(
              indicator: statementModel.amount > 0
                  ? DotIndicator(
                      color: Color(0xff66c97f),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    )
                  : DotIndicator(
                      color: Theme.of(context).errorColor,
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
              startConnector: SolidLineConnector(),
              endConnector: SolidLineConnector(),
            ),
            contents: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    statementModel.operationType,
                  ),
                  Text(
                    NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                        .format((statementModel.amountConverted)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction(
      {Key key, @required this.transactions, @required this.showDetails})
      : assert(transactions != null),
        super(key: key);

  final List<StatementModel> transactions;
  final bool showDetails;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: transactions.length,
            contentsBuilder: (_, index) {
              if (transactions[index].status != 'COMPLETED') return null;

              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat("dd/MM/yyyy")
                          .format(transactions[index].createdAt),
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18.0,
                          ),
                    ),
                    InnerTimeline(statementModel: transactions[index]),
                    ShowDetails(
                      showDetails: showDetails,
                      transactions: transactions[index],
                    ),
                    Divider()
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              return OutlinedDotIndicator();
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: transactions[index].status == 'COMPLETED'
                  ? Colors.grey
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class ShowDetails extends StatefulWidget {
  ShowDetails({@required this.showDetails, this.transactions});
  bool showDetails;
  StatementModel transactions;
  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            widget.transactions.otherInfo.cupom == null
                ? Container()
                : Builder(
                    builder: (context) => MaterialButton(
                      onPressed: () {
                        setState(() {
                          widget.showDetails = !widget.showDetails;
                        });
                      },
                      elevation: 0,
                      shape: StadiumBorder(),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Detalhes'),
                    ),
                  ),
            Spacer(),
            Text(
              'Ver no Mapa',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 12.0),
            IconButton(
              icon: Icon(
                Icons.map,
              ),
              onPressed: () {
                if (widget.transactions.otherInfo.userLatitude != null) {
                  print(widget.transactions.otherInfo.userLatitude);
                  print(widget.transactions.otherInfo.userLongitude);
                }
              },
            ),
          ],
        ),
        if (widget.showDetails)
          Text((widget.transactions.otherInfo.cupom)
              .toString()
              .replaceAll('@', '\n'))
      ],
    );
  }
}
