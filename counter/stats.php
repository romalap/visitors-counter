<!DOCTYPE html>
<html>

  <head>
    <title>Site Visits Report</title>
  </head>

  <body>

      <h1>Site Visits Report</h1>

      <ul>
				<li><a href="index.php">Main page</a></li>
			</ul>

      <table border = '1'>
        <tr>
          <th>No.</th>
          <th>Visitor</th>
          <th>Total Visits</th>
        </tr>

        <?php

            try {

                $redis = new Redis();
                $redis->connect('127.0.0.1', 6379);

                $siteVisitsMap = 'siteStats';

                $totalVisits = $redis->hLen($siteVisitsMap);

                echo "Total unique visitors is " .  $totalVisits . " \n";

                $siteStats = $redis->HGETALL($siteVisitsMap);

                $i = 1;

                foreach ($siteStats as $visitor => $totalVisits) {

                    echo "<tr>";
                      echo "<td align = 'left'>"   . $i . "."     . "</td>";
                      echo "<td align = 'left'>"   . $visitor     . "</td>";
                      echo "<td align = 'right'>"  . $totalVisits . "</td>";
                    echo "</tr>";

                    $i++;
                }

            } catch (Exception $e) {
                echo $e->getMessage();
            }

        ?>

      </table>
  </body>

</html>
